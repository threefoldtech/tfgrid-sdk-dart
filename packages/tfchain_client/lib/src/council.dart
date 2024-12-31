import 'package:polkadart/multisig/multisig_base.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:tfchain_client/generated/dev/types/pallet_collective/votes.dart';
import 'package:tfchain_client/models/dao.dart';
import 'package:tfchain_client/tfchain_client.dart';

class QueryCouncil {
  final QueryClient client;
  QueryCouncil(this.client);

  Future<List<String>> getProposals() async {
    final hashesJson = await client.api.query.council.proposals();
    print(hashesJson);
    List<String> hashes =
        hashesJson.map((hashList) => hashList.toHex()).toList();
    return hashes;
  }

  Future<ProposalInfo?> getProposal({required String hash}) async {
    try {
      final proposal =
          await client.api.query.council.proposalOf(hash.hexToListInt());
      final ProposalJson = proposal!.toJson();
      return ProposalInfo.fromJson(ProposalJson);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Votes> getProposalVotes({required String hash}) async {
    final votes = await client.api.query.council.voting(hash.hexToListInt());
    return votes!;
  }

  Future<List<String>> members() async {
    final keyring = Keyring();
    final members = await client.api.query.council.members();
    return members.map((member) => keyring.encodeAddress(member)).toList();
  }
}

class Council extends QueryCouncil {
  Council(Client this.client) : super(client);
  final Client client;

  Future<Votes> vote({required String hash, required bool approve}) async {
    final votes = await getProposalVotes(hash: hash);
    final extrinsic = client.api.tx.council.vote(
        index: votes.index, proposal: hash.hexToListInt(), approve: approve);
    await client.apply(extrinsic);

    return getProposalVotes(hash: hash);
  }
}
