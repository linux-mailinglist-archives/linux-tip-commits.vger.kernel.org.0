Return-Path: <linux-tip-commits+bounces-1320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D578D70B2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Jun 2024 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66678281DC4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Jun 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F0154BE3;
	Sat,  1 Jun 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhxP+r3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nASV/q8J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33780152790;
	Sat,  1 Jun 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254341; cv=none; b=K84ndoJzbj5/Vo4f/wFTWfS2sXKijXPde+onSobqviczWv4wHLKe6oXFzNEdpH5l6e+LoLOj+HevsNS1k963B+dSz7zOv1wbYwGGcDRDq05qWCE4F/LW7Su/L2ynBcEVuIh/hi6dWjNYabAxEfkGTF2tv+11VldBI3NjFEEa7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254341; c=relaxed/simple;
	bh=N4+f77hmblsYWyxLqdoO6HFFJ+2yG2uuZNMtKfF1cdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FKxvIeZ7Q59F5I5rwK6kQ3JPekuXX6bXgF4Ugv0HIIcw0/pLX5pBCbE10O7AiakE6RQAJpeZnsXbbB3xCJN2Sz1mfj9hp4rQizpZQQ6msSfPd84MRTWFNlv4aHyAkT2LOHrNO9XwXANsNlWlbPPh66P/03lGrmL/LOFG6rDhYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhxP+r3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nASV/q8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Jun 2024 15:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717254330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwjvXUJwOV2b8jf6WvgH0V8CrS+brHJ3EcpyG+R0d0Q=;
	b=yhxP+r3AWYatGR/QflydLKxujeqTbqGvITT52OlNKs9cMVALLKnR6oU0jPOi7Ku/5LHriD
	WXQU0s3xEiLwIozqA8XXuXd5+HVDyc2xjEnjnFnh+JJ6YtmgaZEQhkmehyJULCYfRE58Jo
	D6geOdgd3b4e6a9ltKSkLzns6Yqka72Er8QyEz0nmMyv2dzSnb/2DGfZcr6O1eflPgdA1p
	XQjn014rMKo36Awd2jfxhXhG6dFKSxTMY1o49QVryhkhyZ/J7CJulxNbEcjXks8fBBNJwQ
	i4jLLs9q9TFTLk+mCPVEYK0YiBji3Ica602qWxAlw6WDdraxco2ltAKbNn8Ubw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717254330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwjvXUJwOV2b8jf6WvgH0V8CrS+brHJ3EcpyG+R0d0Q=;
	b=nASV/q8JdtgMAknDSvbe8FOm67cHaxNdnkLGmUBZDXT6gbI/ee/RtHyCL1No/M3Ieili/b
	GolLVhxgAfyiQBBA==
From: "tip-bot2 for Marcin Juszkiewicz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86, arm: Add missing license tag to syscall tables files
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240229145101.553998-1-marcin@juszkiewicz.com.pl>
References: <20240229145101.553998-1-marcin@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171725433033.10875.630169255677526443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     95e3fa6acf624ca9689397ca7ea881450f3cbe24
Gitweb:        https://git.kernel.org/tip/95e3fa6acf624ca9689397ca7ea881450f3cbe24
Author:        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
AuthorDate:    Thu, 29 Feb 2024 15:51:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 01 Jun 2024 16:53:25 +02:00

x86, arm: Add missing license tag to syscall tables files

syscall*.tbl files were added to make it easier to check which system
calls are supported on each architecture and to check for their numbers.

Arm and x86 files lack Linux-syscall-note license exception present in
files for all other architectures.

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20240229145101.553998-1-marcin@juszkiewicz.com.pl
---
 arch/arm/tools/syscall.tbl             | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 2ed7d22..23c9820 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # Linux system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7fd1f57..9436b67 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 32-bit system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e..129bdd4 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #

