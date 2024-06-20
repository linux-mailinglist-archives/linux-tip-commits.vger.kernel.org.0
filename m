Return-Path: <linux-tip-commits+bounces-1477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C299391107F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF73282DF9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169111B581A;
	Thu, 20 Jun 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jekBWvr3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHkM7Z47"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009B1B5813;
	Thu, 20 Jun 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906612; cv=none; b=aqU15HNXhseLrOKrDprhyWdSyKH7itkcu3JzieXGH8nPURlNpacBzL6WucoAgAQYl9BqX7Us8o7JlQ+1l2ZzGWSIWJlN0+9EuQ1Jchf4fgSNELyYduI2H1xDufzVmv2DnonHc/Ix1ZQ4u3DPrvZEvw11jcPtLDt3GxLh1tt3L8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906612; c=relaxed/simple;
	bh=WHL5Z7NFJmkP6o2gKmrBB+sZ90DJQVbg203TnWLw7Vk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WdcfU7rpTX459LEqQBDvEv0K6w491oHM2EOWlEAY+yUd6dJZcVypt0aM7pFW6tqi5tm3U4TYQMez+dTGsUl+Y63LNZNdlVXPzroweDiZjntZsGwQnFjgx1mNQg+OOmUchcR1TwkA3Ad6a0OHvlwf++3boaNXKAaiC7dSQK1bibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jekBWvr3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHkM7Z47; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Jun 2024 18:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718906608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gy/gBuQ8O8BzEms472c/GTj1Em6A5vh9pBbdj9FbrX4=;
	b=jekBWvr3wXaJuMUqCoad849EXf9nAxNhrHYPo6zt2J1JrQTmRsjPteGePhc4nu4eGYJDwg
	oyX41kxausIxYuAS6qLYt++WLjSAJfl7c6AB+lWa5OMP0Mu9WrStIlFb2Dr6vptMCPTvm+
	ERcUWJG3A1kT9xayKJU+8QRYgcJrzZ8oYQsW7kTm9AHEaUmGYJ/+UjS8CjZEtLVD2duo4n
	vsZF+6r4konlJFNR0iIvZWW8BE0RtFUp2n/osUVGLMgYq6NPoqnRgyvIhj+/0A6JrzfTpL
	3g0Hva1dILw4May6iWZRQRWsOvTT2tUyQGkKdqSlyHZCJJb/1ocCuQYdUEkZ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718906608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gy/gBuQ8O8BzEms472c/GTj1Em6A5vh9pBbdj9FbrX4=;
	b=yHkM7Z47H5OHq7gToP+6sot9pWKySvVOS06R3/Decvsth0DXlzzgozcaa+dJTNc3dxcjaW
	hTfmnimdMtV483AA==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/kconfig: Add as-instr64 macro to properly
 evaluate AS_WRUSS
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240612050257.3670768-1-masahiroy@kernel.org>
References: <20240612050257.3670768-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171890660748.10875.18198708223194702721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     469169803d52a5d8f0dc781090638e851a7d22b1
Gitweb:        https://git.kernel.org/tip/469169803d52a5d8f0dc781090638e851a7d22b1
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 12 Jun 2024 14:02:55 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 20 Jun 2024 19:48:18 +02:00

x86/kconfig: Add as-instr64 macro to properly evaluate AS_WRUSS

Some instructions are only available on the 64-bit architecture.

Bi-arch compilers that default to -m32 need the explicit -m64 option
to evaluate them properly.

Fixes: 18e66b695e78 ("x86/shstk: Add Kconfig option for shadow stack")
Closes: https://lore.kernel.org/all/20240612-as-instr-opt-wrussq-v2-1-bd950f7eead7@gmail.com/
Reported-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://lore.kernel.org/r/20240612050257.3670768-1-masahiroy@kernel.org
---
 arch/x86/Kconfig.assembler | 2 +-
 scripts/Kconfig.include    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 59aedf3..6d20a6c 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -36,6 +36,6 @@ config AS_VPCLMULQDQ
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
 
 config AS_WRUSS
-	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
+	def_bool $(as-instr64,wrussq %rax$(comma)(%rbx))
 	help
 	  Supported by binutils >= 2.31 and LLVM integrated assembler
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 3ee8ecf..3500a3d 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,8 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) $(2) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
+as-instr64 = $(as-instr,$(1),$(m64-flag))
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)

