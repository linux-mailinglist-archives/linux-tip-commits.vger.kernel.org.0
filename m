Return-Path: <linux-tip-commits+bounces-4652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A6A7A569
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E36D1696AB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE224EF78;
	Thu,  3 Apr 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dh7oGKo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0njzRPA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AE1F4CB1;
	Thu,  3 Apr 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691065; cv=none; b=jutuOs1XbPeOJIDy+ahBIiWF9acyGp2DWsa7fAMAcaplVae6jfW4RdVB91EChOnWzd6SBJIgbABDznzGyHSBHknzdbB1JzlpO1cSYDET5xZTTvMBD25iIppGh+iGdSXaMA7L27jB6t9+2ydFJm8xhkE33oA6syrOPcikYS2PVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691065; c=relaxed/simple;
	bh=etZhFOEsCa1IJ7BOreRTj6oZJjmWti6+SONBqdXSi3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JdbqGiClipimOpW2JtLmtW6UZqQ61wOoNL0/4DuB+uKbpxjzfjO0hxh/xDNmDFGYjwXrO3i24bbpge+5+uxFJQ3cQE+rST8bkSkdQQcSKAOVtAWk7qJYtqkBLphaaCHVOnkIPBgTL7UJy50NWO+Tb+GKMV5VR1ptuprDAQYO1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dh7oGKo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0njzRPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 14:37:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743691061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8t8/m7qaqizj+efDQB4BdtOfd2V+Pqca1n3K+1BsIo=;
	b=4dh7oGKo7+j3BeMgqxFjrsXyhfdSp9rKtrd/zbHM4RY64kycedpqD3su018mBVxMam4rwO
	afodvnX28MT1mWcLX3ytvrRjEP8LOCjrSrSK5cwdA+8LrjciFx/N7ew6GeXOwNt2AjTIKC
	9pRXkhKqviy7L3ZsvS8tKCel8GiygKc7yXwPgt9fFAWZ+S9wx5rY/6/kvUGgtnPAG3a42p
	mkcmP7IMkkX8PwMBczanG7OzbzfoDO7cQOeugfyHgYMiFDSTKWSND8FA0Cy/DxrG3NkbCd
	jyOg7q6a0uvnbDE0TkaD9X0iFwRZoiL2j7tUW/APmPY9GTNAZfYZJIgknz4v6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743691061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8t8/m7qaqizj+efDQB4BdtOfd2V+Pqca1n3K+1BsIo=;
	b=G0njzRPAA6P3REtvhPsXZhVEdWMFpUmyDfT76RqhAVLpZ9XYgMYCiwx8VR9TjE+GpGJ3Vl
	LIVxy21clVT/ehAQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/idle: Change arguments of mwait_idle_with_hints() to u32
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403073105.245987-1-ubizjak@gmail.com>
References: <20250403073105.245987-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174369106060.31282.12847582125121166988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a17b37a3f416c9e385bbd2b5fc603d337eab76eb
Gitweb:        https://git.kernel.org/tip/a17b37a3f416c9e385bbd2b5fc603d337eab76eb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 03 Apr 2025 09:30:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 16:27:42 +02:00

x86/idle: Change arguments of mwait_idle_with_hints() to u32

All functions in mwait_idle_with_hints() cast eax and ecx arguments
to u32. Propagate argument type to the enclosing function.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250403073105.245987-1-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 6a2ec20..44d3bb2 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -110,7 +110,7 @@ static __always_inline void __sti_mwait(u32 eax, u32 ecx)
  * New with Core Duo processors, MWAIT can take some hints based on CPU
  * capability.
  */
-static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
+static __always_inline void mwait_idle_with_hints(u32 eax, u32 ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
 		const void *addr = &current_thread_info()->flags;

