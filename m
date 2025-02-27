Return-Path: <linux-tip-commits+bounces-3703-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC5A47A85
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D917A3225
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A522A7E9;
	Thu, 27 Feb 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4uWFvc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FSdTdIRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DC22A1E1;
	Thu, 27 Feb 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652936; cv=none; b=Gb9KXQXSN/SqB7In3wAU/SWB+6dgmALJ/DQSz2xU65IAy7jVQODSp4x5ZUxm0CB1MUD6IsRHrM+pDPSsft+rbD5i5ezT6pSuCDJYA5v+s+/uLL9wqxRqJCchnrF5AbrKnlBFnLZ8NikQ4kUqsvtcYqpf5jN3gBy7BKA9Z95tzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652936; c=relaxed/simple;
	bh=OmMnGl1ZqNgBEs3HVP45b623Yz/miYyApjwzHLVAQJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=so8RfeZ9GXytOSJee6hDJ4knqkwviCwFsTU5fES4ROF00LfVWFsXH+dBMqxNapuEXknQ6v2+EfaM9ymlZ46mXuQ7GI+4I58J1wOTjhG1x2SN5TZzFSFETwkAnS3TWpcoNuTHao9t2RyqzxNZKxKdCkHp9Cmj9F3b85vh/Yg+j6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b4uWFvc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FSdTdIRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URJltPZfHHr19sNrS6PPhrOLT+f5OcZ1QFeCJuTKQzg=;
	b=b4uWFvc9dLsaYlGnHic3cIUOeEToLvX5NDegxL5exaD1wDnNeMkbnYn2Z4UsWLA5YmZu11
	YJSUcRtiLemLnH4ABFezdOdJa5HKy3EM5YPzykCLa0VBL8h8BY5D9A/s5sCjSEFoeqoU6P
	Iey1RQvGVo1Ih2G8Mvy23ToOkX0FN+luGQgfLtSm9vlZWOlom6tiUuO4r41RFykcQAv6FC
	SE+PgdWfB6hyGuXgFXczGIIhtgmltkKUq2zppIjBCtGriLv2Y1VFnbWRwbEkfdriAJs0lE
	mJlkIvEvuACu6ceY8iGzQo3pm7n9I6GO1huKT8Wgpf3dHT3NunCV5mkDl7aAfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URJltPZfHHr19sNrS6PPhrOLT+f5OcZ1QFeCJuTKQzg=;
	b=FSdTdIRZTgRwIgqprqB3bC+ClAWwmnLpsvzN78pU6/MAiq68wwFG9tU9FBmLb4S49IJL7T
	G3JendHG+sMMyoBA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Drop CONFIG_SWIOTLB for PAE
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-7-arnd@kernel.org>
References: <20250226213714.4040853-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065293219.10177.12415591209966266534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a8331594036f22dcf037f1a75358bd0985c84cd9
Gitweb:        https://git.kernel.org/tip/a8331594036f22dcf037f1a75358bd0985c84cd9
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:21:59 +01:00

x86/mm: Drop CONFIG_SWIOTLB for PAE

Since kernels with and without CONFIG_X86_PAE are now limited
to the low 4GB of physical address space, there is no need to
use swiotlb any more, so stop selecting this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-7-arnd@kernel.org
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 737a0c6..0e0ec2c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1462,7 +1462,6 @@ config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
 	depends on X86_32 && X86_HAVE_PAE
 	select PHYS_ADDR_T_64BIT
-	select SWIOTLB
 	help
 	  PAE is required for NX support, and furthermore enables
 	  larger swapspace support for non-overcommit purposes. It

