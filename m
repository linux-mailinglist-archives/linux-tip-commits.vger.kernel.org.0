Return-Path: <linux-tip-commits+bounces-5003-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32BA8B327
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5474446F3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624F22FF2D;
	Wed, 16 Apr 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCAUQyCZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LgcWbX42"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5171DDC1B;
	Wed, 16 Apr 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791440; cv=none; b=i4Kptl+bhkOfZzbnk8AO9jVTaCuAQXSWuyiqCzROvmuF8PG7dT90H9ubbNT15HwzthmUmKIOtlRiZVuS4tjygtnGKA97EExSEprPrJhE0dmm+FJrXPfYJ09gdY+V6YinEvHOLhlBSWWNXnJeenGmuVK6faEXnZ0eZU19U4BZw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791440; c=relaxed/simple;
	bh=w5G3ud7gkTzqbiSBtJQjLSCu2Aim2jbjOe81xglMRUU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l8/uYdhkS58i+mZpqVUlj6OWrYN7W6LJJ+N1C8auRUu4ImCnxUJde3FOS7WwRuV+rHdO7e/YMuCMwFp5eZn7tEf5f8mpNK0UtM5skWWRFyOdWzoHSLoV/LCNh6y6HgFjbwbRSxs+61rY1lp1eDz9yYdVPwQ5rYL/4Gw/eVESd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCAUQyCZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LgcWbX42; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clpVXQx8CPS3PQ7MITmFyQBQ1hcdC0uz9/YuhAUXxNM=;
	b=WCAUQyCZETs5qMPQYyPXmjqul2T5AyUk1K9ttZsvoXl1CquBjXY0CZM6xHZKhUSslXNCob
	pa0TC6zcBY5TbndgbNSWoRx53rHNEegRsWoI0TdaUI6BEJpf9YXlfjmc58K1DhPoCOJ7Ea
	+SeuZRYuJBMXa406PVoYbU2w8dOQJkpEYnMHo7Nq+tUGYYWhzVZeJDIkxOXwvy7rHuaGIJ
	Xq9k1GeOB3xVUovZs2b0QPgOuAtGg15pxg4azIchPEJ/q1tVW+Be0R6XJNxwFoy+ARCKRi
	qnl7CgVbSL+Sl7g87bQiZfwUVO1sd2i4RBeGcjxaTHKc9V89hXogoQ30Ce7rtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clpVXQx8CPS3PQ7MITmFyQBQ1hcdC0uz9/YuhAUXxNM=;
	b=LgcWbX42Fqd1e5oRLAB5ZvUtneRhumK/KQywjsd7Epqm46ErrUYu7Dvdv5gaZPBnHkuOCm
	GjHRYdoEhvy8H/Dw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove export of mxcsr_feature_mask
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-10-chang.seok.bae@intel.com>
References: <20250416021720.12305-10-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479143521.31282.3594786085295136242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     70fe4a0266ef156f3a49071da0d9ea6af0f49c44
Gitweb:        https://git.kernel.org/tip/70fe4a0266ef156f3a49071da0d9ea6af0f49c44
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 10:01:03 +02:00

x86/fpu: Remove export of mxcsr_feature_mask

The variable was previously referenced in KVM code but the last usage was
removed by:

    ea4d6938d4c0 ("x86/fpu: Replace KVMs home brewed FPU copy from user")

Remove its export symbol.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-10-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 16b6611..2d9b5e6 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -100,7 +100,6 @@ static void __init fpu__init_system_early_generic(void)
  * Boot time FPU feature detection code:
  */
 unsigned int mxcsr_feature_mask __ro_after_init = 0xffffffffu;
-EXPORT_SYMBOL_GPL(mxcsr_feature_mask);
 
 static void __init fpu__init_system_mxcsr(void)
 {

