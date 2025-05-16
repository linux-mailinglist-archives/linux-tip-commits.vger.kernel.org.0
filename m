Return-Path: <linux-tip-commits+bounces-5569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F06AB98C6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F0C5016AB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8822FE0E;
	Fri, 16 May 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTDI9d0Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMLui3hf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F117B425;
	Fri, 16 May 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387689; cv=none; b=mOsTS9tpg7jwzMiFBINNHb8sNX6f8vXcQDGVG+qTpmSa+1NuXzNuwGgazg4XJ6+yHPPBXFy1UMxysyiXoU/XF7TW/Qf3dCU6MZNRgUc4u4N6yalwd9vQLDr664PtKtRVjsBaR/0JvY0JplUXqlydJMfRmxTWG7n09JV7IvYXIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387689; c=relaxed/simple;
	bh=dlDha9z2voc3K7ZndzuXEpZISD4Js5B+4bqJb6RluJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rS7xTA3Ar+EJPRJFlIh76fnGPKOm6rhtKJZYksvqZq9QQ4rWU/rQMPgycfG/Mh9L7ng6c7shN+xyfMswisExa2JqUaG2PzXS/Nn2HKUesoihPdvZ1eHb4N5kMoNmPsnL44G3L2udeY5M/aYUWdbdaLYhCt48dzV9OeEeQv7wlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTDI9d0Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMLui3hf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 09:28:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747387686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNq/58C7E9N6itWByJdcWr2Jvl1DPdIstlbH/Sr6pkg=;
	b=MTDI9d0Y7t2KbNfzLS34Rr9YLkerz3fWKux0rJTAudwq8Wdw7ztDh/39HDQmRQtADr6ZNw
	s4BV3g3xdpJ5K5OtR2K2lGK5f+06brIHqCi4BluG8Mg3eq1Uj1vk6xm9YL/bvDJUT5Z9QB
	3cW1t2MLQKl54gcRLs7d/JtqgrY+Mj5YFuaj10xjTgiyRs8OqxPro6x+zrMrWki/l0jdfk
	0PrdHY557F19/NgUV4SJC6aJRTXZ6zBJcjDe7yPrGU8zK3+4DOsgxnaJYPnh4hBUOtqe7N
	ajMglc3kMW9nF2sBPvDD3klteycObGxdoCUoYebVuS/uTNHqxcsnLDrrzpB88A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747387686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNq/58C7E9N6itWByJdcWr2Jvl1DPdIstlbH/Sr6pkg=;
	b=LMLui3hfuFH/TR4IXT/ZAn8gOu8qNRSk58PQlrBXtIQvPg/bbvGGNdtE/X0P5v2pGr3asB
	IUzZ6aVTv1XZ5PCA==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Remove duplicated word in warning message
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250516090810.556623-1-lukas.bulwahn@redhat.com>
References: <20250516090810.556623-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738768534.406.13532690829248851233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     03680913744de17fa49e62b1d8f71bab42b0b721
Gitweb:        https://git.kernel.org/tip/03680913744de17fa49e62b1d8f71bab42b0b721
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Fri, 16 May 2025 11:08:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 11:16:52 +02:00

x86/mm: Remove duplicated word in warning message

Commit bbeb69ce3013 ("x86/mm: Remove CONFIG_HIGHMEM64G support") introduces
a new warning message MSG_HIGHMEM_TRIMMED, which accidentally introduces a
duplicated 'for for' in the warning message.

Remove this duplicated word.

This was noticed while reviewing for references to obsolete kernel build
config options.

Fixes: bbeb69ce3013 ("x86/mm: Remove CONFIG_HIGHMEM64G support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: https://lore.kernel.org/r/20250516090810.556623-1-lukas.bulwahn@redhat.com
---
 arch/x86/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index ad662cc..148eba5 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -565,7 +565,7 @@ static void __init lowmem_pfn_init(void)
 	"only %luMB highmem pages available, ignoring highmem size of %luMB!\n"
 
 #define MSG_HIGHMEM_TRIMMED \
-	"Warning: only 4GB will be used. Support for for CONFIG_HIGHMEM64G was removed!\n"
+	"Warning: only 4GB will be used. Support for CONFIG_HIGHMEM64G was removed!\n"
 /*
  * We have more RAM than fits into lowmem - we try to put it into
  * highmem, also taking the highmem=x boot parameter into account:

