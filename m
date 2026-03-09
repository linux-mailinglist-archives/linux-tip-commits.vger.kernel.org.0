Return-Path: <linux-tip-commits+bounces-8403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBe9GpEmr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:13 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D922407D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EBDB305E30C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C741160B;
	Mon,  9 Mar 2026 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCg3B8jp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MI52TF/r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C536AB7C;
	Mon,  9 Mar 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086056; cv=none; b=PDNKCqhyGskYKqhGyxm+Q/xCLuNBQiTi4JOckdAMEA2hdxoEOQVGbInvxb8RrDW5InXzKwYoQHbKBz5uhIz0Zu/xjYc7h6J7mpVPTRmbYELU4z0Vy9DVpY/oIsJUvHh1ZOs93yQBQErOz5CFkuZIlouOjutrqMgGiXe9ofmWA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086056; c=relaxed/simple;
	bh=Igv/CiVzdEQXYqqNBd9xbHmvBrqGCcTRG3YIAFFQcW0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=haWgi+61stLdeWM6CvXqsL7dcqQ/GK2Wgx3PLr1wXUpXcAy7T0SAMpHRTfhyjGOglvMppyMxuOp3TsPEF4ACgjmsgVFsPUsI4H/Vjh1xAL28hh01odub2ZW+yd75jrlpZ8Ew/FqFGC8J3llOFJ48G8vB219BLpeQ9GcEiPuizcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCg3B8jp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MI52TF/r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aObbEGszkdBxXRkt2JBb1Rn0rtGJgiewhzsar9e2LtM=;
	b=lCg3B8jp2EFw78htAcWWMBr6Y0xYgkkBZzOhlVfSggx8ljLUrzQmMluA3I/vsWuKA6Ukbh
	ee1gJ2vuJloLmr0BeNY7A2QsrBsmoojdZVCOFTqiXVol6Y7gCMa6caFR9+X7kWUCY2aZJW
	22UKlRgR5sqqKGJAou5Y3uP/6Qh2RmtSf/Mzr8zys9sTnV7Td+Umjk/Xy/8SbRFpKCuB6F
	cNe2COFlMUL7R1tgUNK2K6WwQnoIomLXPixcZFYZ29bKuSZW9z1HheKDn2lD7cLYS40toD
	fCoBNoT1d26UOP/jh+daRSYK2CqK55hjtouzAl0PCg+hX57m2Y9T4UpXS4vBsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aObbEGszkdBxXRkt2JBb1Rn0rtGJgiewhzsar9e2LtM=;
	b=MI52TF/rTmDr3w2P9wY3cFE6L5BJi4jfhgiFubzoGM3lCk3YJyv2c66xEWp2548bP4oV3p
	Ae1wn7CgZSGSHxAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Handle Clang RSP musical chairs
Cc: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <240e6a172cc73292499334a3724d02ccb3247fc7.1772818491.git.jpoimboe@kernel.org>
References:
 <240e6a172cc73292499334a3724d02ccb3247fc7.1772818491.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605242.1647592.16704999572041610391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D9D922407D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8403-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto,msgid.link:url,linutronix.de:dkim,arndb.de:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     7fdaa640c810cb42090a182c33f905bcc47a616a
Gitweb:        https://git.kernel.org/tip/7fdaa640c810cb42090a182c33f905bcc47=
a616a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 06 Mar 2026 09:35:06 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 09 Mar 2026 08:45:10 -07:00

objtool: Handle Clang RSP musical chairs

For no apparent reason (possibly related to CONFIG_KMSAN), Clang can
randomly pass the value of RSP to other registers and then back again to
RSP.  Handle that accordingly.

Fixes the following warnings:

  drivers/input/misc/uinput.o: warning: objtool: uinput_str_to_user+0x165: un=
defined stack state
  drivers/input/misc/uinput.o: warning: objtool: uinput_str_to_user+0x165: un=
known CFA base reg -1

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/90956545-2066-46e3-b547-10c884582eb0@app.fast=
mail.com
Link: https://patch.msgid.link/240e6a172cc73292499334a3724d02ccb3247fc7.17728=
18491.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c | 62 +++++++++++---------------------
 tools/objtool/check.c           | 14 +++++++-
 2 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 73bfea2..c581782 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -395,52 +395,36 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
 		if (!rex_w)
 			break;
=20
-		if (modrm_reg =3D=3D CFI_SP) {
-
-			if (mod_is_reg()) {
-				/* mov %rsp, reg */
-				ADD_OP(op) {
-					op->src.type =3D OP_SRC_REG;
-					op->src.reg =3D CFI_SP;
-					op->dest.type =3D OP_DEST_REG;
-					op->dest.reg =3D modrm_rm;
-				}
-				break;
-
-			} else {
-				/* skip RIP relative displacement */
-				if (is_RIP())
-					break;
-
-				/* skip nontrivial SIB */
-				if (have_SIB()) {
-					modrm_rm =3D sib_base;
-					if (sib_index !=3D CFI_SP)
-						break;
-				}
-
-				/* mov %rsp, disp(%reg) */
-				ADD_OP(op) {
-					op->src.type =3D OP_SRC_REG;
-					op->src.reg =3D CFI_SP;
-					op->dest.type =3D OP_DEST_REG_INDIRECT;
-					op->dest.reg =3D modrm_rm;
-					op->dest.offset =3D ins.displacement.value;
-				}
-				break;
+		if (mod_is_reg()) {
+			/* mov reg, reg */
+			ADD_OP(op) {
+				op->src.type =3D OP_SRC_REG;
+				op->src.reg =3D modrm_reg;
+				op->dest.type =3D OP_DEST_REG;
+				op->dest.reg =3D modrm_rm;
 			}
-
 			break;
 		}
=20
-		if (rm_is_reg(CFI_SP)) {
+		/* skip RIP relative displacement */
+		if (is_RIP())
+			break;
=20
-			/* mov reg, %rsp */
+		/* skip nontrivial SIB */
+		if (have_SIB()) {
+			modrm_rm =3D sib_base;
+			if (sib_index !=3D CFI_SP)
+				break;
+		}
+
+		/* mov %rsp, disp(%reg) */
+		if (modrm_reg =3D=3D CFI_SP) {
 			ADD_OP(op) {
 				op->src.type =3D OP_SRC_REG;
-				op->src.reg =3D modrm_reg;
-				op->dest.type =3D OP_DEST_REG;
-				op->dest.reg =3D CFI_SP;
+				op->src.reg =3D CFI_SP;
+				op->dest.type =3D OP_DEST_REG_INDIRECT;
+				op->dest.reg =3D modrm_rm;
+				op->dest.offset =3D ins.displacement.value;
 			}
 			break;
 		}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a30379e..786b2f2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3000,6 +3000,20 @@ static int update_cfi_state(struct instruction *insn,
 				cfi->stack_size +=3D 8;
 			}
=20
+			else if (cfi->vals[op->src.reg].base =3D=3D CFI_CFA) {
+				/*
+				 * Clang RSP musical chairs:
+				 *
+				 *   mov %rsp, %rdx [handled above]
+				 *   ...
+				 *   mov %rdx, %rbx [handled here]
+				 *   ...
+				 *   mov %rbx, %rsp [handled above]
+				 */
+				cfi->vals[op->dest.reg].base =3D CFI_CFA;
+				cfi->vals[op->dest.reg].offset =3D cfi->vals[op->src.reg].offset;
+			}
+
=20
 			break;
=20

