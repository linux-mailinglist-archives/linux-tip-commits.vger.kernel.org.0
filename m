Return-Path: <linux-tip-commits+bounces-7573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2808C9C46D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 02 Dec 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7531F3495BE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Dec 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D3288C0A;
	Tue,  2 Dec 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vU0vTZm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ce6WvXzZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF98256C71;
	Tue,  2 Dec 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693956; cv=none; b=rwdYuT4quiotMoltCocUMrzQHYZRLp9H1it2mMl6KxUENzWkqLYyGmF6GeYarKGV9OGeV7ehiCGJd0Ygwv7+3sbg4znETCwr5xI7glCenbBtGAzB15EC7buMt2L0Vow/r2nNv09TAkNr4zoQodVbqxnC/ykVYWEMh4tSQZySG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693956; c=relaxed/simple;
	bh=eXM+nTQ2rLDhk5tehZamxcI3FbqZZh3qF2ODqZVL+2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JsnEaPT6DL5gWDerEn3u0T2epSqndVMmoCft9Ka+qYE8WeM12Uoc8Jqlmcc9n4oIOwdD4P5McbzhAsdDKW99sK7Lz3C0Tc/19rfibPK2mgfnXsoeiAM0jk0aydT5lcSKuHcqr5xXhrq1hVc9g4XKu9Y4ndIcHRwSiidkJ4K4fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vU0vTZm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ce6WvXzZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Dec 2025 16:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764693953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJWIJ6IN/COLJZOsTj1T81fxYSorJH2SKe8syIQ2XvM=;
	b=vU0vTZm9Hj3cwCZ99P33oG1cuKe3jH28lT9avH1vWbkhK8KSbXixOIurWDtdpdU6QjiJ25
	VZ1IRq19GT10/GOpnSmVbmm3iccSEs+tyD8xyO8VqliP6eBa9hMVvA7ze0b0l80FGKaZdh
	W3ck3OM4vWSpCpvls4pmZbSk7VknUh9RuBmiEa34zGHKq5MiZfZ08onaeYXL4YofdgKK9l
	iqEQK7+sLfFtT3FkRzL7IBIclNlYCbBZCS+va+Ng101fCqimt5JpEjjIscXwq8lTn11zB0
	YNb7PJBdwR4Bjd/6mcE9Uj8VmvhwUApQaOrTyONOmPBCkaE1lO9VrEbV2JoxZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764693953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJWIJ6IN/COLJZOsTj1T81fxYSorJH2SKe8syIQ2XvM=;
	b=Ce6WvXzZpRopvcrXDoD99vRAhxMyh+AyBiAjAjexe9pdSB/nnYL2m1i0qa4CUButqexlMS
	I3QG9iwUWvYDLdAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix stack overflow in validate_branch()
Cc: Nathan Chancellor <nathan@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <21bb161c23ca0d8c942a960505c0d327ca2dc7dc.1764691895.git.jpoimboe@kernel.org>
References:
 <21bb161c23ca0d8c942a960505c0d327ca2dc7dc.1764691895.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176469387080.498.13134077611244424666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0c314a881cac61a80a0e05309fafd48c55dd3afc
Gitweb:        https://git.kernel.org/tip/0c314a881cac61a80a0e05309fafd48c55d=
d3afc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 08:16:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 17:40:35 +01:00

objtool: Fix stack overflow in validate_branch()

On an allmodconfig kernel compiled with Clang, objtool is segfaulting in
drivers/scsi/qla2xxx/qla2xxx.o due to a stack overflow in
validate_branch().

Due in part to KASAN being enabled, the qla2xxx code has a large number
of conditional jumps, causing objtool to go quite deep in its recursion.

By far the biggest offender of stack usage is the recently added
'prev_state' stack variable in validate_insn(), coming in at 328 bytes.

Move that variable (and its tracing usage) to handle_insn_ops() and make
handle_insn_ops() noinline to keep its stack frame outside the recursive
call chain.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: fcb268b47a2f ("objtool: Trace instruction state changes during functio=
n validation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/21bb161c23ca0d8c942a960505c0d327ca2dc7dc.17646=
91895.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/20251201202329.GA3225984@ax162
---
 tools/objtool/check.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9ec0e07..3f79993 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3282,18 +3282,19 @@ static int propagate_alt_cfi(struct objtool_file *fil=
e, struct instruction *insn
 	return 0;
 }
=20
-static int handle_insn_ops(struct instruction *insn,
-			   struct instruction *next_insn,
-			   struct insn_state *state)
+static int noinline handle_insn_ops(struct instruction *insn,
+				    struct instruction *next_insn,
+				    struct insn_state *state)
 {
+	struct insn_state prev_state __maybe_unused =3D *state;
 	struct stack_op *op;
-	int ret;
+	int ret =3D 0;
=20
 	for (op =3D insn->stack_ops; op; op =3D op->next) {
=20
 		ret =3D update_cfi_state(insn, next_insn, &state->cfi, op);
 		if (ret)
-			return ret;
+			goto done;
=20
 		if (!opts.uaccess || !insn->alt_group)
 			continue;
@@ -3303,7 +3304,8 @@ static int handle_insn_ops(struct instruction *insn,
 				state->uaccess_stack =3D 1;
 			} else if (state->uaccess_stack >> 31) {
 				WARN_INSN(insn, "PUSHF stack exhausted");
-				return 1;
+				ret =3D 1;
+				goto done;
 			}
 			state->uaccess_stack <<=3D 1;
 			state->uaccess_stack  |=3D state->uaccess;
@@ -3319,7 +3321,10 @@ static int handle_insn_ops(struct instruction *insn,
 		}
 	}
=20
-	return 0;
+done:
+	TRACE_INSN_STATE(insn, &prev_state, state);
+
+	return ret;
 }
=20
 static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
@@ -3694,8 +3699,6 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 			 struct instruction *prev_insn, struct instruction *next_insn,
 			 bool *dead_end)
 {
-	/* prev_state and alt_name are not used if there is no disassembly support =
*/
-	struct insn_state prev_state __maybe_unused;
 	char *alt_name __maybe_unused =3D NULL;
 	struct alternative *alt;
 	u8 visited;
@@ -3798,11 +3801,7 @@ static int validate_insn(struct objtool_file *file, st=
ruct symbol *func,
 	if (skip_alt_group(insn))
 		return 0;
=20
-	prev_state =3D *statep;
-	ret =3D handle_insn_ops(insn, next_insn, statep);
-	TRACE_INSN_STATE(insn, &prev_state, statep);
-
-	if (ret)
+	if (handle_insn_ops(insn, next_insn, statep))
 		return 1;
=20
 	switch (insn->type) {

