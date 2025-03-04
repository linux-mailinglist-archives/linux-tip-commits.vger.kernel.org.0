Return-Path: <linux-tip-commits+bounces-3900-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3AA4DA6D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434401884ABB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF955202991;
	Tue,  4 Mar 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGXVKs2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBsle6ir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36520125D;
	Tue,  4 Mar 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083984; cv=none; b=ZpqAFzA4l1owsAnu7MrRFAGJLOQsj0+2fpIqJJNr/yZXOUVZGmH2qGistWvuvJktfYLGOc8yyzjtuxoPy7ZEIrHu6HuQYoOJbT9owKRuNGM3o/zaM0YjxlzlQ/eWjmWNsbjphatBFkChJrI9zud7Mn+YTiYzDMp1E9kk0leAqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083984; c=relaxed/simple;
	bh=bjTb7UFweSKeEja1DAGC7xUKq3WZy7RsqfvI7p/7K+E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SLpwPtK0719eZYgfn6VFSAcZKNrFuIrRb4CWVnyJ2AU2h8+Tm0OqmT4ZGvrmiYrMeQz1af9aSghkqACIh0VevDE2pMaAqmV3CCtc/T5syvmW9AvnaDQDpjXbjqYvLKg8MDmesbzfeDeR3mLe+SA0oRPpHp3QlkcHdCg10YGG2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGXVKs2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBsle6ir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1W3z977r/1eiDn6gyeaRad0PYnMclADS7IIF7spivI=;
	b=zGXVKs2ecT3vAvV/53CRQUFMluoUjYIMVD7Q/LjH6WzTBH2TOGYtk62UWXlcbQPhuQPG7l
	1/xUQ+AHt/BagjCs2m1GXWVzG4GVkTTFfUWVXf/FxP5eIDBsf4SpYMR9mjtVHJ4qB1LVQk
	pscBAJWRoxh2Fao5uDi8HDGUawr4s8VfL+JRCYxZmgpjGwq/4wYA1exfdcOpi1/OVt4xku
	Z5rCedA8n//75H67nV5aHM2+Gk2FRHF8kl1O9GYb3AG+ftkPVR+ESSJeCX8rqZnbtKHjCy
	f5C2k7HRd3ZGcANCuoDledaTfOsYRWPuoFSJqMb30A4wJ2ujpHFOoCAYsg6KAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1W3z977r/1eiDn6gyeaRad0PYnMclADS7IIF7spivI=;
	b=bBsle6ir/Ljj2cpR78qyKO/Gw3SbW7AFNkbuBnckx7EBHVZcFHss+9eIdseoDACz5rtlGU
	YS5Z1PluGtIUXvBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpuid: Include <linux/build_bug.h> in <asm/cpuid.h>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-5-darwi@linutronix.de>
References: <20250304085152.51092-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398095.14745.801348386934644512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     97c7d5723537de08e076892e07d6089ae9777965
Gitweb:        https://git.kernel.org/tip/97c7d5723537de08e076892e07d6089ae9777965
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:17:33 +01:00

x86/cpuid: Include <linux/build_bug.h> in <asm/cpuid.h>

<asm/cpuid.h> uses static_assert() at multiple locations but it does not
include the CPP macro's definition at linux/build_bug.h.

Include the needed header to make <asm/cpuid.h> self-sufficient.

This gets triggered when cpuid.h is included in new C files, which is to
be done in further commits.

Fixes: 43d86e3cd9a7 ("x86/cpu: Provide cpuid_read() et al.")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-5-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index b2b9b4e..a92e4b0 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 #include <asm/string.h>

