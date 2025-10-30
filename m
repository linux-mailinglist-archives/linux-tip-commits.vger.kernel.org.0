Return-Path: <linux-tip-commits+bounces-7104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822BC223AB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 513494ED42D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9D1B4F2C;
	Thu, 30 Oct 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gw3pZT7l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovG0+rdI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57034D3BA;
	Thu, 30 Oct 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855716; cv=none; b=VLWjwgOVzafvpdqC8x9AlG/rifKeb2luQDFaI2hn2Vsg3rlW7EEqJ3mR/wrotYzDZ0GH+nV5QhQ5gcWp1WuH/J4c7zhrUlW6UTbFfCYWl4iHeEZJaHKY/Hs6YYS3jw4EIKk+O7jH3wa4ZKaz3tAoM0WsGhp/tJtPUXbHTEOlLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855716; c=relaxed/simple;
	bh=JvQ2Jl+k2/NkCEY25csTOAJzLX9SR3LCCmKebVb33e4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JFmRHx9Z+XKX7/IWtbusuohCCSNM6SjiT7rhMsOLZj6QgWkYPvxdC0z2Gz1RO4kBzwPXN8uW6fOs9mTIVpWqHwEKYA+Z0Yse4U3jvvljbdj3BmDm3iQN4Z6y5dVYrLSXSpKhYgfvueyfgtsgUiS3H+iF2UX/Jl/yLIf6hKMnbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gw3pZT7l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovG0+rdI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 Oct 2025 20:21:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761855712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpnMxQVh0/ihe9VRDzpkKN3SYEpKw+YNhn7OnKVVJJI=;
	b=gw3pZT7l3zpQ2Yl2Pibomus3QHMgkUG2mUbrrCqIhNd9w4p3bxsrp7Ud9pw8BNl888NxQs
	rDFTOSOH0L636ugm+ik0jtQaNDtSTq7z3O9ci0iFKSClFH6R8VM6Yy55DIAbTFONA7PFXX
	qm1qblgk/yJP/1EQtRYg53CrW/Ov6/TQip4DhY963OeH74SIfTaCf8TaFVZZXtiKMI0G4F
	M73s0rYteV4dYuwXAv+jo8bqlIkU7fSfXaLncPBf23Vd4etQnAj7F4ajKDJ7tWkAED/9jT
	/PLE6lk+bO6WeyQNDUy8w61OUrD5iBbY6ZvWPJ0aBKC3Yi8KRR+koC4zOmFNRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761855712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpnMxQVh0/ihe9VRDzpkKN3SYEpKw+YNhn7OnKVVJJI=;
	b=ovG0+rdIwgB59wg7n5KZ5FzeQLyDNHgiDw+LJneNBZ3cF8RQWAP9kd2+ZiW1d6PrUiB9vM
	x5ontY99DAk0H3AQ==
From: "tip-bot2 for Yu Peng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode: Mark early_parse_cmdline() as __init
Cc: Yu Peng <pengyu@kylinos.cn>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251030123757.1410904-1-pengyu@kylinos.cn>
References: <20251030123757.1410904-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176185570829.2601451.17127553971644289493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ca8313fd83399ea1d18e695c2ae9b259985c9e1f
Gitweb:        https://git.kernel.org/tip/ca8313fd83399ea1d18e695c2ae9b259985=
c9e1f
Author:        Yu Peng <pengyu@kylinos.cn>
AuthorDate:    Thu, 30 Oct 2025 20:37:57 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Oct 2025 14:33:31 +01:00

x86/microcode: Mark early_parse_cmdline() as __init

Fix section mismatch warning reported by modpost:

  .text:early_parse_cmdline() -> .init.data:boot_command_line

The function early_parse_cmdline() is only called during init and accesses
init data, so mark it __init to match its usage.

  [ bp: This happens only when the toolchain fails to inline the function and
    I haven't been able to reproduce it with any toolchain I'm using. Patch is
    obviously correct regardless. ]

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/all/20251030123757.1410904-1-pengyu@kylinos.cn
---
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index d7baec8..ccc83b0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -136,7 +136,7 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
=20
-static void early_parse_cmdline(void)
+static void __init early_parse_cmdline(void)
 {
 	char cmd_buf[64] =3D {};
 	char *s, *p =3D cmd_buf;

