Return-Path: <linux-tip-commits+bounces-4460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF15A6EBB9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FE1188C33E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D2253F36;
	Tue, 25 Mar 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUhH3K8X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7w1MT0D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F25253F38;
	Tue, 25 Mar 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891710; cv=none; b=U23dqXYUjEPkeFvCHDo6freMO+qDfvEii+bYyvvPw2mZ2LBJvzdmuB6y0wZAgCf3FHc6+mb2r5KxYxd2QYOMDB55Qijbtz6xXOxjZWAlEs1oq6whPyC7kZvwEZlBPma+KTy3ie/JkzMxs0Uicj4Mz5zztRi6143F6ZBvnDm4TIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891710; c=relaxed/simple;
	bh=rf2HfJYhUCin9SFhHhfRIF6ycCo5RE0VFxL/DmZhIK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y2BtHtAwmtdPVanVQ/loxDviFpLhUpR6d9GOP7fSwjrKny81Ml1jp62tKRQv7vTirDaJOMiUK3M/AchV3FrDMi+S3NMkymOLUPpjhMrYMfAOZxIfTKWGoL5CD/ZZ7X5UtR9KWqljcA/rxm1PAFggZ0wY0lE1kQLX8e2FCXVWyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUhH3K8X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7w1MT0D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLUJH341Jr7pWgGf+1jPktPWaXVpq+ZfMdJANEsSPXg=;
	b=oUhH3K8XDEEwSmadg9wtENZqMs876tYy8va0lnnIRLbxq09lzCG6wD7r82ouHcW52hxfKt
	ZSNwiTRvqS439bE3GFtMActWC2uewypQzsme0SfVtKBdk8utoVj3z1brYhmrQjyPrbA27e
	ovPfIx9a28eOTfcFKn3ke7MAEr2Q5wcg8lvGBk42uMOTP789u5iuKKlLhCpm9BlGtKEYTy
	7PgKfVWCAYkMtrjYj9Gd5fUDUhd5OkIOmBRtlvtHIOGz+CzTrBAM4IJ8NxllJyVnkOZ8yl
	vd3E4UolylzkVaiG1sCP8XCsY6W6enqaKLeKfmdKl6uebbNrL5u2mYSFyUXDZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLUJH341Jr7pWgGf+1jPktPWaXVpq+ZfMdJANEsSPXg=;
	b=m7w1MT0DyiK6VqkqjjMF+tFK8wIKBYE2keuQcCNZFzURoH+xDqpOK8vPLq6KYlZwmx4U6F
	zSt2n1l0TcyXuRDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Properly disable uaccess validation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0e95581c1d2107fb5f59418edf2b26bba38b0cbb.1742852846.git.jpoimboe@kernel.org>
References:
 <0e95581c1d2107fb5f59418edf2b26bba38b0cbb.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170674.14745.2223636098662849576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     e1a9dda74dbffbc3fa2069ff418a1876dc99fb14
Gitweb:        https://git.kernel.org/tip/e1a9dda74dbffbc3fa2069ff418a1876dc99fb14
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:26 +01:00

objtool: Properly disable uaccess validation

If opts.uaccess isn't set, the uaccess validation is disabled, but only
partially: it doesn't read the uaccess_safe_builtin list but still tries
to do the validation.  Disable it completely to prevent false warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/0e95581c1d2107fb5f59418edf2b26bba38b0cbb.1742852846.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cb66e6b..b0ef14a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3187,7 +3187,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3647,6 +3647,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
@@ -3656,6 +3659,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
@@ -4114,7 +4120,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)

