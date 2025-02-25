Return-Path: <linux-tip-commits+bounces-3626-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C81A44FE2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 23:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5152C3AB210
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85021517D;
	Tue, 25 Feb 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Sb/yGRU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0yfjY2S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01682135CA;
	Tue, 25 Feb 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522120; cv=none; b=tLzKm1z1pS7qr+FnaLNpiLvLrYHWT8dEmhCr3UffkHckdBdpO1YmBgxxSaOggtCOESTKS5Feo7XEIFSvAN4AB8F2q5jFZ0Icefp6CUyoTEjefC+PCnnZLZtlLtnR/q3ASt7r3rM2hCY98ERQE0e+NU7tN9oRwVyw9LCn68G72Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522120; c=relaxed/simple;
	bh=2lynZGjH5NIE5T4if8PE2TsgWu9XKSidgYSwPADMRnY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gTYVm+4STCvWz1ojaqMDgH9/MksdykaXlBy0Z7MO1u463ZGMMTOjX4MwG0j5d66FeY4B3Xj1JvGIhg1Wv7lZQOTKhI5iU1SN/Qgbs+s7BDSMniWygWlpX2EdBHKkXZr+QNOzF8x8ADBa6nPs9VrLXjOo39/Y3C3fM1eyzAAcwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Sb/yGRU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0yfjY2S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 22:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740522116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ptpXKuBybhw/QKQL2zs4ppqiv+yrL5SJGDQgNj5eno=;
	b=2Sb/yGRUrbFnpJcwwGIxANOFPsceJ6vlTheZ7PmX4Yb6fkFGkinHy21H08gUb/mD5uEM6B
	khf8zekUBRKkiNudDW0+E8tKy9DVs/Ybyx4ObZpbLjGHh66tGt/ZCquDiyZ21/V9j0fErZ
	fcE6AwzHwj0sKbfv7mlpM5cdKlN5VbI+MrXmbDrexTNyu2tVkapkQX+w8GdBqH8hvDdzfO
	YmIGN6osMWTd6ybwoGR17AtxgbGoH5W6u0UZin2DrlKGL6pPVlxln+sUdaRNCdOEsS9bNC
	EHP35zlkMjCL4FufwUGR9IFxmTAxz/800BQ5o4PbrJZMnZYQca7R1ht+vdPVtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740522116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ptpXKuBybhw/QKQL2zs4ppqiv+yrL5SJGDQgNj5eno=;
	b=v0yfjY2S1qM9KyOt0D8FjvHo4X6P0WSnuofJSJHT35YImTQyScgpwOen77Wy7Hgjk9/wsJ
	gS3Zfp0EGoyCnLBQ==
From: "tip-bot2 for Daniel Sneddon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Fix kernel-doc warning
Cc: kernel test robot <lkp@intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241219155227.685692-1-daniel.sneddon@linux.intel.com>
References: <20241219155227.685692-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174052211537.10177.9851928630532239563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0f6750b15ffdf274668b12824b09bd49ea854e18
Gitweb:        https://git.kernel.org/tip/0f6750b15ffdf274668b12824b09bd49ea854e18
Author:        Daniel Sneddon <daniel.sneddon@linux.intel.com>
AuthorDate:    Thu, 19 Dec 2024 08:52:27 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 23:12:58 +01:00

x86/entry: Fix kernel-doc warning

The do_int80_emulation() function is missing a kernel-doc formatted
description of its argument. This is causing a warning when building
with W=1. Add a brief description of the argument to satisfy
kernel-doc.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241219155227.685692-1-daniel.sneddon@linux.intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202412131236.a5HhOqXo-lkp@intel.com/
---
 arch/x86/entry/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 94941c5..14db5b8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -190,6 +190,7 @@ static __always_inline bool int80_is_external(void)
 
 /**
  * do_int80_emulation - 32-bit legacy syscall C entry from asm
+ * @regs: syscall arguments in struct pt_args on the stack.
  *
  * This entry point can be used by 32-bit and 64-bit programs to perform
  * 32-bit system calls.  Instances of INT $0x80 can be found inline in

