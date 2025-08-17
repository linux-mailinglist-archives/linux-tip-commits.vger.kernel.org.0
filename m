Return-Path: <linux-tip-commits+bounces-6260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C8B292C4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE16D7ACC70
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A37F2877E1;
	Sun, 17 Aug 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0p2HhLq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBd8R+GK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5D21FF58;
	Sun, 17 Aug 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755428173; cv=none; b=JURGHTbjiXnNJKC2fn83UcgrGeDdCW9MSt7A8CpNjx9dlWtVRi5CPorwfPjYHbVGUDQj7NgKngl/R2RarcpCI5fRGOvP7z7HrBrUAMC8aASTI1+sSkaohokzz+wAncvhRuMc+cLNxWwrPzbRnal8uVNCReusmSWEv3JXEtSnVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755428173; c=relaxed/simple;
	bh=a0mVONyG+QE28m4STXg3Fdn1kemXptPxbZWUpdkiHC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AU0AoNs/0Vb6tYJY0yZsd41n5Rk2r83qEamrb3KhZVkl0lUwxL+7PusoVlm6lP0iKAajE4OHXSbAh4x362PhMMSRbdLmndiAECmHzIog/W/2sCZK9dkzf9WxurVl8/EJ0eNCmt3V+qJIvqZbbe7qHcWypskAXj9fZ45RifdJD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0p2HhLq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBd8R+GK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 17 Aug 2025 10:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755428170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJf17pEIJOMQZrqaAC3Ns3eQlB0C566bYgK+KrXXIhA=;
	b=O0p2HhLqwAb8QqH0JwfYND+4pzhf3/tKauCX6N+1xNrQDUh2LN7SX09YMgNEUNbHfneYcs
	fWGgKvPFASw7wKUggLXwWDr6IlwYdsEet/LzVvKnScI7tOgZCPqe3d2VhgvDMUbs1TMkBg
	rJhSnvr5RxTInAzrN6eRx6XHrTw4p4DJxHoDIMhRSaaXp0oNMfxvNiCES2yJvNBWAQ/nn9
	MuiYmph4LZQHnca800heyvBWy7VOM6gdo9JqYu0x4sGz3zcyqtXONqnU8Rmk6zYT768Fmm
	Fb9ODvtC6ZK60It/wE0J+jxZyYxE7SqCHlH51DUZSqP0StKRqaBVrzG6sdPoAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755428170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJf17pEIJOMQZrqaAC3Ns3eQlB0C566bYgK+KrXXIhA=;
	b=xBd8R+GKzY7F1qANU/xofu+ilNWWoiKM2KjEWgp9k47FjvvEY7z7lsJJFlwtezGlrlxKNl
	0oScIOeIFgwUcZCw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove cc-option from -mskip-rax-setup
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-5-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-5-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175542816793.1420.6740634856322288739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     337927d9895a800a63ffe852616ab05f5d304971
Gitweb:        https://git.kernel.org/tip/337927d9895a800a63ffe852616ab05f5d3=
04971
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:41 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 17 Aug 2025 12:36:36 +02:00

x86/build: Remove cc-option from -mskip-rax-setup

This has been supported in GCC since 5.1 and clang since 14.0. Now that x86
requires LLVM 15 or newer since

  7861640aac52 ("x86/build: Raise the minimum LLVM version to 15.0.0"),

this flag can be unconditionally added, saving a compiler invocation.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Dfbe575b652f5bdcc459=
f447a0e6f0e059996d4ef
Link: https://github.com/llvm/llvm-project/commit/a9fba2be35db674971382e38b99=
a31403444d9bf
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-5-ff7f19457523=
@kernel.org
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1bbf943..4b4e2a3 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -160,7 +160,7 @@ else
         KBUILD_CFLAGS +=3D $(cc_stack_align8)
=20
 	# Use -mskip-rax-setup if supported.
-	KBUILD_CFLAGS +=3D $(call cc-option,-mskip-rax-setup)
+	KBUILD_CFLAGS +=3D -mskip-rax-setup
=20
 ifdef CONFIG_X86_NATIVE_CPU
         KBUILD_CFLAGS +=3D -march=3Dnative

