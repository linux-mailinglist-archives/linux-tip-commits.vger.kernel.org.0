Return-Path: <linux-tip-commits+bounces-6915-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1542BE2A00
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DB85814C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CF33A01F;
	Thu, 16 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/tBovmk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lnu/4Sdf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A583376AD;
	Thu, 16 Oct 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608410; cv=none; b=kvld3KFTW2bCROaqNr/gzUwoLqzB+MpbgidFNypU5PfxxRJGn41z15r0M0l1slFST1LQk+aLIwJYQnR3511PgiAmFr35nY/eO7M66t9Of+6brR2eEg6wci7bm8zAVdTpHKSgrecO/uIcUVbixC72C19mCmNGVlyyvc/CO/mfRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608410; c=relaxed/simple;
	bh=3Nhm6Z9e56FttrvP6m3iIJIOtDgwNrbbtup/fd+Fk0E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RDfiO3WRe/9XKGt5O6bqM5w/TpiqPFvrY8/HCEcL2e/sooh9x2hSTn92mOZabSkLdVlwRRdJ4D8gigXNxvT3h/xtwGIa2x011vRCPhDdvz8d0XSLFKCleksRN0D2HwnWX5BZ07d2qn9bK06VmgbG0xs0fRzuL8eVS5ncFKuces8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/tBovmk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lnu/4Sdf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mJgMDrsDBvHsncf54mdydrpL/AzM6376CYAzTwoTAW4=;
	b=E/tBovmkR/LFmQoZ0IIpqF0OtB6AHIvD/x72OMD7gotxBnlbTcX3/g1y0CVArvvBOqdyZB
	r2FfiUCZXgrL40GfUbHLa4bsNAyVWc6GaAHlqGOGYIZMdw6lScVUjcf7DS3wsky9sr7Vgr
	Kv95X13NEX3dJLt7L1JaStB2/fIQ9FXqKzR2q1mNm1BQQ2GE5VfU25jKBGTOwRt7sSuL6X
	TT2VqLrf1zNn1WoWErY4q7TNW/xq8v2THzFwqdVFjIqz2D5LfiZ4Z5sRxfLLRpvf5aRZIV
	Ye/w649sVnVUzWqW/8Vw20TZ++raEmm19MNuFlWRb1Xpzua210DWhSDoTPjTXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mJgMDrsDBvHsncf54mdydrpL/AzM6376CYAzTwoTAW4=;
	b=Lnu/4Sdf1ytpHKD70/7vhLKI0fFsQnQyynb8O+wEjDB65dC0WGLLsb+33NtmdVVYu9cooe
	oIL+AamdVSKxMADg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] x86/kprobes: Remove STACK_FRAME_NON_STANDARD annotation
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839577.709179.15457781058454266907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     122679ebf90eeff97c5f793ed9a289197e0fbb2c
Gitweb:        https://git.kernel.org/tip/122679ebf90eeff97c5f793ed9a289197e0=
fbb2c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:12 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

x86/kprobes: Remove STACK_FRAME_NON_STANDARD annotation

Since commit 877b145f0f47 ("x86/kprobes: Move trampoline code into
RODATA"), the optprobe template code is no longer analyzed by objtool so
it doesn't need to be ignored.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 0aabd4c..6f826a0 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -103,7 +103,6 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, un=
signed long val)
=20
 asm (
 			".pushsection .rodata\n"
-			"optprobe_template_func:\n"
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -160,9 +159,6 @@ asm (
 			"optprobe_template_end:\n"
 			".popsection\n");
=20
-void optprobe_template_func(void);
-STACK_FRAME_NON_STANDARD(optprobe_template_func);
-
 #define TMPL_CLAC_IDX \
 	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \

