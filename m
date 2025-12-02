Return-Path: <linux-tip-commits+bounces-7572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F549C9C320
	for <lists+linux-tip-commits@lfdr.de>; Tue, 02 Dec 2025 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58A864E438A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Dec 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36197283FC5;
	Tue,  2 Dec 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYXZxYOn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vh/525z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142D281357;
	Tue,  2 Dec 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692828; cv=none; b=Pb3VGr43KgzZyXxq2N4j5VpaGtc0nhjRL4+L55+n6QXGCtcsP+Zo3u8ZmgDK7iYHxeltct8HwhV+t6vZ/M+Xe7cdKprYgFxHC4KTCjAT7xw5u+wqwx9H4p/CEtyxJR6W/35WPRkYTienN3OVqGhtn+uW1VRDd2Uu3S06kgn6Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692828; c=relaxed/simple;
	bh=MagwZDTBzoum0BGr/+2eLfR4rRo3fQWBP5gG37cLkuU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F8UT2skB/FTvHHdMQ6HdxDZS+rKxTPgmFxR77fQqHpPvVMRTat3zX9n85WAwYMfikYmNd5iIWncKzoBsJWOE8wYeL35G3TZVtwoFC9F9qfZe6nXl/PFMPaLhVxTN7pkoECyREOZ+xx4cImIHUQhYQErt9ZxsASBaYKchaTXqz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYXZxYOn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vh/525z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Dec 2025 16:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764692824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D/gPvoc+/lcRiDWiCvBoVquHDebShfmCM8STJCx05k=;
	b=uYXZxYOnYC/kTNe8wetsuEcD22Uakk7JhuxWDje7D4igQfxHgGYea0zpdynOsV8fULoLbM
	OhA4kyW24UvOeDlc/27lX76bP6aQ0i08NzldcwTxrnCBU3YUP0HUxHIMW1N6V4F0hObWAe
	cLlOi983QzEs+83MjsC24DyRFDQCPRFMxz9BCbWQGHQkr1N1fpbzWCdLGtcLwV9XUSMhCy
	R3NoEPw6jMEqpmNNuF33ASbuQQpM2SEfYllwtiq766uUqs1Lxc8EUMdjFD873R4tE15WKs
	qUxzjGXq/gcDciU5vEse/VC7IaycD55txuUIOTG5CNUMU6YeIBdTGNiKzZ85cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764692824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D/gPvoc+/lcRiDWiCvBoVquHDebShfmCM8STJCx05k=;
	b=1vh/525zg6TYpZafPDC3WaAUGxLldJecaXnBXBdL5PqofXVjOnT49sFkH7PdaRkerRq7+Q
	TIpAy+kJXxh5LMCg==
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
Message-ID: <176469282298.498.17970695187992519968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     3db8fd69e50b6723cd509f219363b64567c287be
Gitweb:        https://git.kernel.org/tip/3db8fd69e50b6723cd509f219363b64567c=
287be
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 08:16:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 17:21:18 +01:00

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
 tools/objtool/check.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9ec0e07..4e7b44f 100644
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
@@ -3319,6 +3321,8 @@ static int handle_insn_ops(struct instruction *insn,
 		}
 	}
=20
+done:
+	TRACE_INSN_STATE(insn, &prev_state, state);
 	return 0;
 }
=20
@@ -3694,8 +3698,6 @@ static int validate_insn(struct objtool_file *file, str=
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
@@ -3798,11 +3800,7 @@ static int validate_insn(struct objtool_file *file, st=
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

