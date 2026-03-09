Return-Path: <linux-tip-commits+bounces-8402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGQ8NIklr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:49 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EC24069A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3D0E3004063
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D8345745;
	Mon,  9 Mar 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVkbY+4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qA8gpzyB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790333C183;
	Mon,  9 Mar 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086055; cv=none; b=YN9iH6zGVdfLq7XgXePnFTtH3/3n5Oep0Ue8L8B4kdWnn0iAoO3Ti4Sq9vhSn8oCzJnJWlvwrZ1+m29kK9uvXdaX4h/teOXpXu+l1/VZ5JrtK6XBANRPtHeFuPoHk88j1gXtSzee8Y/B8EHa7lGaaSF2HWcMVWlX0xTQjsk6ZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086055; c=relaxed/simple;
	bh=P7M36b1RwJFgrpwM6D4yas9EKEp3umkr987RmA3gRmc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GQ/IdpCu3t64e3WXxQRBEQMt5fDnz2UWpCwDspOuVOBQ7wXZahgpUtfrIheM7IIQ2ymdx0wzcDrWJjCDTwtdRqugmrLNeuRaDwIHHLAmD9EZ3hGpA/1TgKHEE0F3SvKusUdCPISW8+x/aVTjqvMr7yRmPMMmMn+OF4yqPcM2ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVkbY+4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qA8gpzyB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQNRSBGPQC2T8We5jwLq7Fs4Y+y0vw1W2hSxru8LAgI=;
	b=XVkbY+4DuCbrE+ae/rfdOKyKDEi8OROJAvG1+iv5xTOMpWSMCgRZIrow+sbl07SjJ/vU6b
	pkrAZ9POuXihiVqKgZ2FrYRYkmQl23174y1WMpZgvxaV0VmbYUv5jv4n2YNNbwUjdIqFyV
	lUI8TT9BBRFNKT5jHPZlS9jdYrCe7BDLF2J1EOPG/4+q7Se8nS3AaIlPNXOtBO+4Mqw3uB
	lK3Px/bP0/GKmktm9thfNMDBimQty+YpQi9R4+bLpjKC6rJBMOtVK3CkKN314gsuaVA6VU
	HQ20g/EqWa4MAPXXATXVMa+S3Tqf1iWyO4CS6+ZUFMgTrGQ2CkYkMbx7voywbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQNRSBGPQC2T8We5jwLq7Fs4Y+y0vw1W2hSxru8LAgI=;
	b=qA8gpzyBKnOGdzQu6zoLcK0tZ8LzYfwrEB60qztMbCPesikzVJrx3ztFd68TD+H0wJuTz3
	unWT0z9bmy91amBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix another stack overflow in
 validate_branch()
Cc: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <8b97f62d083457f3b0a29a424275f7957dd3372f.1772821683.git.jpoimboe@kernel.org>
References:
 <8b97f62d083457f3b0a29a424275f7957dd3372f.1772821683.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605132.1647592.5098920400033875777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D90EC24069A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8402-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:dkim,msgid.link:url,cfa.base:url];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     9a73f085dc91980ab7fcc5e9716f4449424b3b59
Gitweb:        https://git.kernel.org/tip/9a73f085dc91980ab7fcc5e9716f4449424=
b3b59
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 06 Mar 2026 10:28:14 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 09 Mar 2026 08:45:13 -07:00

objtool: Fix another stack overflow in validate_branch()

The insn state is getting saved on the stack twice for each recursive
iteration.  No need for that, once is enough.

Fixes the following reported stack overflow:

  drivers/scsi/qla2xxx/qla_dbg.o: error: SIGSEGV: objtool stack overflow!
  Segmentation fault

Fixes: 70589843b36f ("objtool: Add option to trace function validation")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/90956545-2066-46e3-b547-10c884582eb0@app.fast=
mail.com
Link: https://patch.msgid.link/8b97f62d083457f3b0a29a424275f7957dd3372f.17728=
21683.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 786b2f2..91b3ff4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3748,7 +3748,7 @@ static void checksum_update_insn(struct objtool_file *f=
ile, struct symbol *func,
 static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state);
 static int do_validate_branch(struct objtool_file *file, struct symbol *func,
-			      struct instruction *insn, struct insn_state state);
+			      struct instruction *insn, struct insn_state *state);
=20
 static int validate_insn(struct objtool_file *file, struct symbol *func,
 			 struct instruction *insn, struct insn_state *statep,
@@ -4013,7 +4013,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
  * tools/objtool/Documentation/objtool.txt.
  */
 static int do_validate_branch(struct objtool_file *file, struct symbol *func,
-			      struct instruction *insn, struct insn_state state)
+			      struct instruction *insn, struct insn_state *state)
 {
 	struct instruction *next_insn, *prev_insn =3D NULL;
 	bool dead_end;
@@ -4044,7 +4044,7 @@ static int do_validate_branch(struct objtool_file *file=
, struct symbol *func,
 			return 1;
 		}
=20
-		ret =3D validate_insn(file, func, insn, &state, prev_insn, next_insn,
+		ret =3D validate_insn(file, func, insn, state, prev_insn, next_insn,
 				    &dead_end);
=20
 		if (!insn->trace) {
@@ -4055,7 +4055,7 @@ static int do_validate_branch(struct objtool_file *file=
, struct symbol *func,
 		}
=20
 		if (!dead_end && !next_insn) {
-			if (state.cfi.cfa.base =3D=3D CFI_UNDEFINED)
+			if (state->cfi.cfa.base =3D=3D CFI_UNDEFINED)
 				return 0;
 			if (file->ignore_unreachables)
 				return 0;
@@ -4080,7 +4080,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 	int ret;
=20
 	trace_depth_inc();
-	ret =3D do_validate_branch(file, func, insn, state);
+	ret =3D do_validate_branch(file, func, insn, &state);
 	trace_depth_dec();
=20
 	return ret;

