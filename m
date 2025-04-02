Return-Path: <linux-tip-commits+bounces-4627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C246A796B6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3684818958B5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BB1F3B83;
	Wed,  2 Apr 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCqF0Bxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TSWAQg4g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B71F12FF;
	Wed,  2 Apr 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626637; cv=none; b=MGxjkeWNvXd/6KTc9sCEyVnOUQXFcf5gAzzfk605P10rt+OVAHIe7sXU1600Axxw5zn7igYKfAE7aPyfhG8OUCWylZlFmHPMFsUJT5MRv2N8YuyJ1n2/Qe+QyD2ukpY6bNHhEFF74E84DhDTwEW0UBGDRemldB3NOWU4PQXFZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626637; c=relaxed/simple;
	bh=fkaNrrHQQ6rdEpwOUZ8rZrb/+0w5rZ9HeaamWRx0o0k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FezGRvlfTQqoCEeWeV7COjUYWiC4eKBtUy7LOjJykAZ1f1IaNB92oSy083YvzM+aS5C57hQOiYigzYmVmhEZlU7JhX15vTDF7zKelgURr0lgplafqGbAEENn5eS/8Hkxx4CfJp2RpZqy7S30q8ytntdZB9WHBqTXZwuAmyf5Pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCqF0Bxy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TSWAQg4g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 20:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743626633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhtLDrTniWifHYaM2qYL51SZFDLOiYXLxfz3oz+Z8i8=;
	b=FCqF0Bxy9oVgQzoEIyL/z33q65vz1N9oY4nQcOF6ge03UX/dpDyZu7BYi5TQUxIWuxjdOu
	iVOq8tfSyNBAqvH6w7iz5aGe0r8biAl3agWqYvZlyFKbIEKrooTxM+e+wvp/MQrRIlmXdF
	fx0CXvbU8Xuz6vpb5+YuBdSzJs6VkxQW5u3l9LKvexfS4sqLDwYLRiVEuDW973wzMxShln
	sdPgWbh1+C8c57XmqJgWfLjvkOyR7yBS06zXi31M1TvON8I/tBAQxYaVADN1aAWHeFaUln
	cf0SCdjFFCKOGrGHLRtChwYCQkVSyOXM44fWwsmUxvA1H0FycQxwsvN3lASVmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743626633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhtLDrTniWifHYaM2qYL51SZFDLOiYXLxfz3oz+Z8i8=;
	b=TSWAQg4gzNFfWf5mXFukYAqQDRVXL2ARL5dSSX1ECV4DckGuF3qksYf2Q96ae46W9J5MLQ
	HzzI6fMNlZCCaFDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/idle: Use MONITOR and MWAIT mnemonics in <asm/mwait.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402180827.3762-2-ubizjak@gmail.com>
References: <20250402180827.3762-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174362663244.14745.8528127585586564065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     cd3b85b27542968198e3d588a2bc0591930ee2ee
Gitweb:        https://git.kernel.org/tip/cd3b85b27542968198e3d588a2bc0591930ee2ee
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 22:26:17 +02:00

x86/idle: Use MONITOR and MWAIT mnemonics in <asm/mwait.h>

Current minimum required version of binutils is 2.25,
which supports MONITOR and MWAIT instruction mnemonics.

Replace the byte-wise specification of MONITOR and
MWAIT with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402180827.3762-2-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 3377869..006b150 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -27,9 +27,7 @@
 
 static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitor %eax, %ecx, %edx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc8;"
-		     :: "a" (eax), "c" (ecx), "d"(edx));
+	asm volatile("monitor %0, %1, %2" :: "a" (eax), "c" (ecx), "d" (edx));
 }
 
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
@@ -43,9 +41,7 @@ static __always_inline void __mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
-	/* "mwait %eax, %ecx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc9;"
-		     :: "a" (eax), "c" (ecx));
+	asm volatile("mwait %0, %1" :: "a" (eax), "c" (ecx));
 }
 
 /*
@@ -95,9 +91,8 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
 static __always_inline void __sti_mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
-	/* "mwait %eax, %ecx;" */
-	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
-		     :: "a" (eax), "c" (ecx));
+
+	asm volatile("sti; mwait %0, %1" :: "a" (eax), "c" (ecx));
 }
 
 /*

