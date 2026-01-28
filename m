Return-Path: <linux-tip-commits+bounces-8127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGcvIvHMeWmOzgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:46:41 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C49E547
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D36E130094F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C92857CD;
	Wed, 28 Jan 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kPyzf0pl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2IwsCG9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168A23EAB3;
	Wed, 28 Jan 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589999; cv=none; b=s+cR5uoZH0ofuIjtGF95XZ74fiYqOpesqH/I1Ipq43ai7SQvUY9ddMVYWO1ftYCJmoeWWO0n3sPSSa01obt56funqchv4KVqbuOqUhLfwYz33S+UEdr1bKfsd3FIFbLuuKA7x3O1uurvWSlVZ9c11C8iJ55GNKTbWwbyzPFUdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589999; c=relaxed/simple;
	bh=6hG/9/IewOB/bgvKwDsiepdbfBND2J7UzfyR/SBkTbk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JPXoESLd4rfBS+HYBEL+5qLhG/RUxXYIwps+2OT/73c6YedH+HeHDOla8imcNq+BfQCtRP9nuGLwEFOt8999rDYhNlCLqhN9sVJPvBxouixqE+t7PLidjTHfWNZb+vVM8y+IszhjId+KECxTOAWaHuRFy4ts8nOCzLEXPTS+ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kPyzf0pl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z2IwsCG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:46:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFSw8j+9FPCLOGcXh8HyK433ErQ601vjQC3es1o7gW0=;
	b=kPyzf0plTMPFVsbRd6Y41tl2NYSkHwM3fzpB+RNUsBCqNgcvGG537DcyhbVN7bP2vKl7kT
	9VNyKuTHG+P65dCusxTOcQYI5LaTlfmZf3timSsvTuYs6lpwO5b9ntbSSWTsBk4j/TGkyh
	U07VMpCq/PEwpvSERDP+zVWwbl4icOjORaA3GsS324Wjn3cFJCVJZhQNpbwh8f48QM53l3
	rk5BXsANTiiGFzN5sVhRtvAzaQLvvtTNc5Y3xJu7A+ib+Nxi6TlbWRXxJxZUXh5jFfhFVl
	LTjS5hB3eN6ctHMwLfZ35LRondlxStX3fzE1qwWzAtDpaPvHA6Tkjm4RVoYEyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFSw8j+9FPCLOGcXh8HyK433ErQ601vjQC3es1o7gW0=;
	b=Z2IwsCG9uFBDD9a7NRJVG02n2InFbFa34A7fYBotNTLre/VuonMfINqWAfOd8kk4jej6iW
	/FYUjTE4N85OmhDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool/klp: Fix bug table handling for __WARN_printf()
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <a8e0a714b9da962858842b9aecd63b4900927c88.1769406850.git.jpoimboe@kernel.org>
References:
 <a8e0a714b9da962858842b9aecd63b4900927c88.1769406850.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958996941.510.4641148219429711553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8127-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: E66C49E547
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f2dba60339a6299e181671e95293efe312237e2d
Gitweb:        https://git.kernel.org/tip/f2dba60339a6299e181671e95293efe3122=
37e2d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 25 Jan 2026 21:56:39 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 27 Jan 2026 08:20:47 -08:00

objtool/klp: Fix bug table handling for __WARN_printf()

Running objtool klp-diff on a changed function which uses WARN() can
fail with:

  vmlinux.o: error: objtool: md_run+0x866: failed to convert reloc sym '__bug=
_table' to its proper format

The problem is that since commit 5b472b6e5bd9 ("x86_64/bug: Implement
__WARN_printf()"), each __WARN_printf() call site now directly
references its bug table entry.  klp-diff errors out when it can't
convert such section-based references to object symbols (because bug
table entries don't have symbols).

Luckily, klp-diff already has code to create symbols for bug table
entries.  Move that code earlier, before function diffing.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Fixes: 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
Reported-by: Song Liu <song@kernel.org>
Tested-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/a8e0a714b9da962858842b9aecd63b4900927c88.17694=
06850.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 4d1f9e9..d94531e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1425,9 +1425,6 @@ static int clone_special_sections(struct elfs *e)
 {
 	struct section *patched_sec;
=20
-	if (create_fake_symbols(e->patched))
-		return -1;
-
 	for_each_sec(e->patched, patched_sec) {
 		if (is_special_section(patched_sec)) {
 			if (clone_special_section(e, patched_sec))
@@ -1704,6 +1701,17 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (!e.out)
 		return -1;
=20
+	/*
+	 * Special section fake symbols are needed so that individual special
+	 * section entries can be extracted by clone_special_sections().
+	 *
+	 * Note the fake symbols are also needed by clone_included_functions()
+	 * because __WARN_printf() call sites add references to bug table
+	 * entries in the calling functions.
+	 */
+	if (create_fake_symbols(e.patched))
+		return -1;
+
 	if (clone_included_functions(&e))
 		return -1;
=20

