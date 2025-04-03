Return-Path: <linux-tip-commits+bounces-4645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B3A7A3CD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525497A62CC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11D2505BE;
	Thu,  3 Apr 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7vtv2Co";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trQvvoK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD124FC1E;
	Thu,  3 Apr 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687226; cv=none; b=aQ8zhAb4mCBhQSh12Oycny7FFgRe5DkOkbVlVGNgKERcC01uO6+7TfX6dILwIwJefOaD569qdJewOnlxIxX8EdRNzVEZ4JN9NkCUt7SzPMKRDuLp+x+TmPwI3uSbYKKEJngD6Mxa9lt6NuXvyZau9Kt6VzmEcYHfqbAldMy/nfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687226; c=relaxed/simple;
	bh=7XwG4HUa5xetKc2uhjmPwZCNGNoX1tMsj9H7qbUAVlE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PqiU55Pc9GYj6rgWy6Z0VFhoWIht+lE+Aa6X/v8a0d7oU9lFG4b7JrKE+2XybJXpIEUj69GsnxbUbeNjXgAvI2i++b7rxOVKw4k6t5JcTVsHcUAqcq9atqsfAKougXzBmwMi/r/nS7fn6yDjaRKvY5rMNpmJExTWiPB5Rr4TGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7vtv2Co; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=trQvvoK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sA9icH03kmbpuo1QM1XlN65i5gVJFVFyKv5WE4I+EBo=;
	b=V7vtv2Co0D/8mknAarhYI1sx8TxA8QfRTnjjr7M1O321opOYgKz3rvzzDi/LKLDjXAJs02
	Z/ORuFRzZ2IOboywzFy7fPq3pk0yX0ai5LjgNW0XmPmUW/UcNLO2WGmyHFfLFoC8hd3+GX
	uLQK0FE57437+Hg0JIfqDaxMzFNv2ZUcm2KeRyrCBY68ZLLcpTYhclskOnTJbHE3OuUyIl
	Vp1FWneoJcfBDFymQKE0Y+G8IE4/Lfc0/pUzMowAO7FPjI9/3C00RNHxyCb47WGMzSDiIS
	t7M9pv2M9yRvZ7F8sL1NiCaJ1OTtl0XBo5QQU08mwfvbh5YxUITM+KizUnVVYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sA9icH03kmbpuo1QM1XlN65i5gVJFVFyKv5WE4I+EBo=;
	b=trQvvoK3dam6K4TU+EhqbGPmxeMJAdcWG39QPC2QSFFsiK2KD1gmdFfYbMBLLCuVbRaJHk
	L6JHsqVAuRKWa3AA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Remove export of local_touch_nmi()
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-5-sohil.mehta@intel.com>
References: <20250327234629.3953536-5-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722204.30396.18213856176127912330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     6325f947014644ff39e5902afa48238af8f92e0e
Gitweb:        https://git.kernel.org/tip/6325f947014644ff39e5902afa48238af8f92e0e
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:24 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:06 +02:00

x86/nmi: Remove export of local_touch_nmi()

Commit:

  feb6cd6a0f9f ("thermal/intel_powerclamp: stop sched tick in forced idle")

got rid of the last exported user of local_touch_nmi() a while back.

Remove the unnecessary export.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-5-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 6a5dc35..cdfb386 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -745,4 +745,3 @@ void local_touch_nmi(void)
 {
 	__this_cpu_write(last_nmi_rip, 0);
 }
-EXPORT_SYMBOL_GPL(local_touch_nmi);

