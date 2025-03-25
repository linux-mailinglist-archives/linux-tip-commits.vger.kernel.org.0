Return-Path: <linux-tip-commits+bounces-4505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E7A6ECAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B716A083
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B82257442;
	Tue, 25 Mar 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZHDXFm6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="km03q2Ez"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1655257427;
	Tue, 25 Mar 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895393; cv=none; b=l14iX9kXtMKOmReJm4CU9dek4rgMFWio1Nc+0/AxcCtwzo7z93Ni5gUJ9thYOq7B/B4NUynNJF//pVT9+tGctXyphPPjY+Mhz9FPGLZDTlXSib8UdhBK0rmnnr0vHF6N6sLBBYV6apLRUjQlnVJ/mz62N4QfJzEPwLuZSO6vwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895393; c=relaxed/simple;
	bh=y3wN1cdw8clbEGMAdoQtx53MckdL0ULmvm8gVg33Ooc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gUz9AAORaiA6MTJEStkhIwluuoRoNJUp05HJJRr5RUgbbS9l9qyysbBxR6aKbuFrD8ED+vtIvfcV4ZLSW3fppSD1P7NfgwNcwYZhvSTAHujpr0M8x9u3ouxM5rPAkfEQ0CV5wTGiP8WEvPeMr4iQ5JSWzUXf3zeyGgKdzd1dKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZHDXFm6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=km03q2Ez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf8mT4O3LugsxFBh13X8OD6i0dcA5k7ZKPJnDEeCMro=;
	b=cZHDXFm614Fb3/ntsKEfUm/JYAnUr4XHMWdhZO9OQUTgirxGxWUEf+rgg1gCdH10gfJF7e
	qrSDINiikGcvu+rL81QswcNRVTyAGAZyWplkJAyjPUXeV26g2Y1JOncye9ag/83Z8ePs8c
	7OOklVRMzJDERzDRp4SJuueeVe723rZDO0/K5dSO22o+ijdDn4ssLd+4C/VNy/C9Cy7E7A
	UWc8tYWQfc6eSzrUL/njpmKBFf9fT9WyrTMI7RLnEU4xLqljMjbmOjfrXQn1GQ3FfFMLfY
	8sav0bbglD8D/kdQBVIs14DoAHHGxrk8qDMbg+0v46/vkIevfXlIPGzcr70WpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf8mT4O3LugsxFBh13X8OD6i0dcA5k7ZKPJnDEeCMro=;
	b=km03q2EzOeXogekCX9f/bYrqq5xgs8nhVy7uvB1pdKE6NA9L/diXUoeJ04q8BmixpjxNGm
	Kyailxq/9TAyv2Dw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-15-darwi@linutronix.de>
References: <20250324133324.23458-15-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538969.14745.12173307532137925350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     071f4ad6494aff76589ca30a2d13e74bc1e33e0f
Gitweb:        https://git.kernel.org/tip/071f4ad6494aff76589ca30a2d13e74bc1e33e0f
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:43 +01:00

x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()

Per Documentation/filesystems/sysfs.rst, a sysfs attribute's show()
method should only use sysfs_emit() or sysfs_emit_at() when returning
values to user space.

Use sysfs_emit() for the AMD L3 cache sysfs attributes cache_disable_0,
cache_disable_1, and subcaches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-15-darwi@linutronix.de
---
 arch/x86/kernel/cpu/amd_cache_disable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd_cache_disable.c b/arch/x86/kernel/cpu/amd_cache_disable.c
index 6d53aee..d860ad3 100644
--- a/arch/x86/kernel/cpu/amd_cache_disable.c
+++ b/arch/x86/kernel/cpu/amd_cache_disable.c
@@ -66,9 +66,9 @@ static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int 
 
 	index = amd_get_l3_disable_slot(nb, slot);
 	if (index >= 0)
-		return sprintf(buf, "%d\n", index);
+		return sysfs_emit(buf, "%d\n", index);
 
-	return sprintf(buf, "FREE\n");
+	return sysfs_emit(buf, "FREE\n");
 }
 
 #define SHOW_CACHE_DISABLE(slot)					\
@@ -189,7 +189,7 @@ static ssize_t subcaches_show(struct device *dev, struct device_attribute *attr,
 	struct cacheinfo *ci = dev_get_drvdata(dev);
 	int cpu = cpumask_first(&ci->shared_cpu_map);
 
-	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
+	return sysfs_emit(buf, "%x\n", amd_get_subcaches(cpu));
 }
 
 static ssize_t subcaches_store(struct device *dev,

