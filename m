Return-Path: <linux-tip-commits+bounces-4811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C5FA8300A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77023AC60A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84F276023;
	Wed,  9 Apr 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtPWL4Yk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIC40b8w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C30253B46;
	Wed,  9 Apr 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225624; cv=none; b=hkq9tAd8PY+uUcrnBpRdQ+1mnDM/n1g/bPmTn9e5tTksp+2UzzgrqnPA+NI7tq3fkhY7XC6zLtbwQlez1LlG4OQ+HTFDMfSDqQWYzelYDdVdE/riiB1E93QyhKbvF/BuGtOgQtTZjY38QO6L2P9x6oueB+LJA/1eNlx+qKSBrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225624; c=relaxed/simple;
	bh=zIMufi1pfOGJfgv3IG37PKRPOjR+foHGW/ZRMqh25oo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GnyJnPl09YHmxhHSuUuP7JE13C+X5teqIMg4WCxRj+NkhH1gnc3kydPe/RFuBhbSf5BS/uqsvBKONV+0bjwJXM8k0Spj++6I/yEuWLj8H4CMuSn9vtK0W2YccQzx2/mtB38mxG1FXTg21RBXchJExLXIMPj0h1bvn28Pcj4fato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtPWL4Yk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIC40b8w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:06:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744225620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuDP/EVbH11rcxXyzzva+s7aNZK+w/uOWpaXPhLmzIg=;
	b=XtPWL4YkaLVVBLnheKle0GghklSbT3jRNFj4gt6pceuc+RdvJ9o22sHvX7iMQqwbk9lxmt
	MpTs9qK0Dtb3pxXNdKOOjULFfH/1OEM2E3mHYg58DR1Qhs+AiAfPAqCdY49U184kMR/1cJ
	N6KU8zpfzj5eoz66jRG9xY8K/yGSfPS08Id70UdsAeNXyyJaUxGt+RM/o9m8xiMEK9mRNV
	4lq8COfs3yJPu87ivl0mRRut4cXACET62sj+5otoxMLmvOkdXNlSTudBipRoRejIZJ9EzH
	J/Vt88hzT5PCxYBIz0/aHQQXcFHTNkEMTmLhn084ct0b10x1748WcHC7KjxDsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744225620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuDP/EVbH11rcxXyzzva+s7aNZK+w/uOWpaXPhLmzIg=;
	b=ZIC40b8wdb5frL3n1zQJZBH0EtnNvgGYnRq2dzJ7i8PFtsLWl6SHRPegSvlbsfE5k/In65
	j7rsPa1k5E/nPRCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Add missing ACCESS_PRIVATE() for
 hrtimer::function
Cc: kernel test robot <lkp@intel.com>, Nam Cao <namcao@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250408103854.1851093-1-namcao@linutronix.de>
References: <20250408103854.1851093-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422561796.31282.2133089235929784026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     2424e146bee00ddb4d4f79d3224f54634ca8d2bc
Gitweb:        https://git.kernel.org/tip/2424e146bee00ddb4d4f79d3224f54634ca8d2bc
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Tue, 08 Apr 2025 12:38:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 21:00:42 +02:00

hrtimer: Add missing ACCESS_PRIVATE() for hrtimer::function

The "function" field of struct hrtimer has been changed to private, but
two instances have not been converted to use ACCESS_PRIVATE().

Convert them to use ACCESS_PRIVATE().

Fixes: 04257da0c99c ("hrtimers: Make callback function pointer private")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250408103854.1851093-1-namcao@linutronix.de
Closes: https://lore.kernel.org/oe-kbuild-all/202504071931.vOVl13tt-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202504072155.5UAZjYGU-lkp@intel.com/
---
 include/linux/hrtimer.h | 2 +-
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1adcba3..1ef867b 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -345,7 +345,7 @@ static inline void hrtimer_update_function(struct hrtimer *timer,
 	if (WARN_ON_ONCE(!function))
 		return;
 #endif
-	timer->function = function;
+	ACCESS_PRIVATE(timer, function) = function;
 }
 
 /* Forward a hrtimer so it expires after now: */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 517ee25..30899a8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -366,7 +366,7 @@ static const struct debug_obj_descr hrtimer_debug_descr;
 
 static void *hrtimer_debug_hint(void *addr)
 {
-	return ((struct hrtimer *) addr)->function;
+	return ACCESS_PRIVATE((struct hrtimer *)addr, function);
 }
 
 /*

