Return-Path: <linux-tip-commits+bounces-5262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A80AAC175
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402711B62A3E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2627817A;
	Tue,  6 May 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nyfB08c4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8mHRzvNH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A4278146;
	Tue,  6 May 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527738; cv=none; b=nzTW+8+aflrfyji/KU54n4H3lwX5P3ZupAR4l+2a+ldOxc2WsWVYudsZiWmWlUHoXeOA2IKuCHf3uze0543a4F2LPxvffAl9KYiB+5QljQheYwuqRTVvc3WRNMUuTtSAXMwkzLpHg1qwsCNrrsUr5PlzbbhjjFJEwOtMOFxQ6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527738; c=relaxed/simple;
	bh=vU6k5cOcaW+QlQmmW8UKKSU8sXE1XKCOEEseg/2SJSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yr88IusaUz9YtPN64o3BBfaFq1VPEjEyktVRyOoL/LvmJJFmrDsuSLU8OWREL9cC7tFJe3iMextOOwcxOYVEt2/lmpc7kqp5YgpdgAb9hmojB5zm7UQ3L7HHkBFGSrPnt/tBw77LTfWJd6u2kQmkPsMZ8MFfIz/4iJT/sOQ+hhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nyfB08c4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8mHRzvNH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 10:35:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746527733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzGZJUznRbqdMULqXMgRDTBZ7vyIUj2xBkKLT5FG0WQ=;
	b=nyfB08c4QqDl9U41yc/9Jdica4jJ298CxDZRPERXst1T3bBRmmPvGgH7wGZZWQ6tgL4zky
	nIu1U7o1MPxRaMz3e/kC23rwrZIgiwns8zCzD/rW94YcDLgJMG1aJhV7DTKQiwfcKJxTXe
	WCSBMNxpZ9LAyJisEtFGMs3wS5v7AclCWc4qScXC9kENBCezK1i6abc2zI0PLVfxNjeXF6
	8Mnbb+CUzx0qWzPX/sU6f9MNQJKu9L+Ntr01bvRmPerZA2p34wJkLe+WRhEwa01cA4IJP6
	KlAh9NUh59ESKtmM5M1eGbfZMS5CQlY1274FjsmKSiXSPgYxwRYnp1G4vGKGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746527733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzGZJUznRbqdMULqXMgRDTBZ7vyIUj2xBkKLT5FG0WQ=;
	b=8mHRzvNHgcq+sgHeC4lLBIr98kSR6dhgvSap5phukBuxQuYrYvQbC9yJFxlvJEQeHByz9A
	Ssl10ZUdBoXNbfBQ==
From: "tip-bot2 for Masami Hiramatsu (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/insn: Fix opcode map (!REX2) superscript tags
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <174580489027.388420.15539375184727726142.stgit@devnote2>
References: <174580489027.388420.15539375184727726142.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174652773261.406.11420976495556364687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ca698ec2f07873a448d53c580795c4e023c75393
Gitweb:        https://git.kernel.org/tip/ca698ec2f07873a448d53c580795c4e023c75393
Author:        Masami Hiramatsu (Google) <mhiramat@kernel.org>
AuthorDate:    Mon, 28 Apr 2025 10:48:10 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 12:03:15 +02:00

x86/insn: Fix opcode map (!REX2) superscript tags

Commit:

  159039af8c07 ("x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map")

added (!REX2) superscript with a space, but the correct format requires ','
for concatination with other superscript tags.

Add ',' to generate correct insn attribute tables.

I confirmed with following command:

      arch/x86/lib/x86-opcode-map.txt | grep e8 | head -n 1
  [0xe8] = INAT_MAKE_IMM(INAT_IMM_VWORD32) | INAT_FORCE64 | INAT_NO_REX2,

Fixes: 159039af8c07 ("x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/174580489027.388420.15539375184727726142.stgit@devnote2
---
 arch/x86/lib/x86-opcode-map.txt       | 50 +++++++++++++-------------
 tools/arch/x86/lib/x86-opcode-map.txt | 50 +++++++++++++-------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index f5dd84e..cd3fd51 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index f5dd84e..cd3fd51 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -35,7 +35,7 @@
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
 #
-# REX2 Prefix
+# REX2 Prefix Superscripts
 #  - (!REX2): REX2 is not allowed
 #  - (REX2): REX2 variant e.g. JMPABS
 
@@ -286,10 +286,10 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
-e1: LOOPE/LOOPZ Jb (f64) (!REX2)
-e2: LOOP Jb (f64) (!REX2)
-e3: JrCXZ Jb (f64) (!REX2)
+e0: LOOPNE/LOOPNZ Jb (f64),(!REX2)
+e1: LOOPE/LOOPZ Jb (f64),(!REX2)
+e2: LOOP Jb (f64),(!REX2)
+e3: JrCXZ Jb (f64),(!REX2)
 e4: IN AL,Ib (!REX2)
 e5: IN eAX,Ib (!REX2)
 e6: OUT Ib,AL (!REX2)
@@ -298,10 +298,10 @@ e7: OUT Ib,eAX (!REX2)
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64) (!REX2)
-e9: JMP-near Jz (f64) (!REX2)
-ea: JMP-far Ap (i64) (!REX2)
-eb: JMP-short Jb (f64) (!REX2)
+e8: CALL Jz (f64),(!REX2)
+e9: JMP-near Jz (f64),(!REX2)
+ea: JMP-far Ap (i64),(!REX2)
+eb: JMP-short Jb (f64),(!REX2)
 ec: IN AL,DX (!REX2)
 ed: IN eAX,DX (!REX2)
 ee: OUT DX,AL (!REX2)
@@ -478,22 +478,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64) (!REX2)
-81: JNO Jz (f64) (!REX2)
-82: JB/JC/JNAE Jz (f64) (!REX2)
-83: JAE/JNB/JNC Jz (f64) (!REX2)
-84: JE/JZ Jz (f64) (!REX2)
-85: JNE/JNZ Jz (f64) (!REX2)
-86: JBE/JNA Jz (f64) (!REX2)
-87: JA/JNBE Jz (f64) (!REX2)
-88: JS Jz (f64) (!REX2)
-89: JNS Jz (f64) (!REX2)
-8a: JP/JPE Jz (f64) (!REX2)
-8b: JNP/JPO Jz (f64) (!REX2)
-8c: JL/JNGE Jz (f64) (!REX2)
-8d: JNL/JGE Jz (f64) (!REX2)
-8e: JLE/JNG Jz (f64) (!REX2)
-8f: JNLE/JG Jz (f64) (!REX2)
+80: JO Jz (f64),(!REX2)
+81: JNO Jz (f64),(!REX2)
+82: JB/JC/JNAE Jz (f64),(!REX2)
+83: JAE/JNB/JNC Jz (f64),(!REX2)
+84: JE/JZ Jz (f64),(!REX2)
+85: JNE/JNZ Jz (f64),(!REX2)
+86: JBE/JNA Jz (f64),(!REX2)
+87: JA/JNBE Jz (f64),(!REX2)
+88: JS Jz (f64),(!REX2)
+89: JNS Jz (f64),(!REX2)
+8a: JP/JPE Jz (f64),(!REX2)
+8b: JNP/JPO Jz (f64),(!REX2)
+8c: JL/JNGE Jz (f64),(!REX2)
+8d: JNL/JGE Jz (f64),(!REX2)
+8e: JLE/JNG Jz (f64),(!REX2)
+8f: JNLE/JG Jz (f64),(!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)

