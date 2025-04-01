Return-Path: <linux-tip-commits+bounces-4611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D26A78260
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BF616232C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD791DB54C;
	Tue,  1 Apr 2025 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoUhMXTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+GH2ZSeq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962420D505;
	Tue,  1 Apr 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533002; cv=none; b=YFAuULV1MbHNhBESJ/TUciyMH+z2AAHRwaf+I+NT66Mr4FwQQGgMZcZuWdAds7OIcR8tLcmkjfKy5+E2lYyJWJGDsO+FnGTsly4HrFgeiz6jhBJY7G+gHtdZV5N1IdzzyKo+Rbzp4adFFGnnc+FyI0mYo4QRjhtEbbolc9EPJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533002; c=relaxed/simple;
	bh=8/C1JKe3fscqaOAHcPivy8Eeb+khbtBI9FxScUINIT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C+guyPJF82spaJmueW4VdGtZaulJCoU0CQUH2HnUG2VtSjAamLRh0ksU+MdhMkvLDN1LuS7RAy65CysOOeidySh2bmU5CrCKp1sPoh1tphMF7MdO3VfC3lQcMOpdfm9f2DwKkibzdTBvwVUregr1YncocTOaMknQltRUpHsTFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoUhMXTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+GH2ZSeq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 18:43:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743532998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2Q2L/7rj3cxpaE4j8vthf2ql42MJVGYI7kIRx6ocME=;
	b=FoUhMXTZbUiOhY0VHQPoFysfCgG3Xllk/+Q0XfPVi5kf9cn3RzmKd8sHf2ivjW2xq/mDG2
	Clg/QYRQsRYL9XN/A9L/6FnXIl6tOAGpXRPqfOKiOs0JXj9XLL86i2L+BBUig47YViCrf4
	PxZHjcToej7UC77sX/CIN94w01HbeU3JJudQC4rL7JoKWXSdSRj2qOjiti0xRciNoQZAw0
	Trlko38JPkIgRKQz35oDNAE5NeThZFZg6ujKtDFoXrbl4vR5tP/uOuUsTzVEdyLaNYK8/P
	YJZSB9/rwzUuHNePa5BeLdMXrE1Hsx+eLNaAr5ms0LVOfuecKQcza1HJer3QGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743532998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2Q2L/7rj3cxpaE4j8vthf2ql42MJVGYI7kIRx6ocME=;
	b=+GH2ZSeqiwFfyrkQ/RSVLF7sH4K5kMrG82hu57BCMr9pNgYZWriN0Tdc2WeiaWW4AtQhj4
	QvPT1HuxsrGxN3CQ==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/iosf_mbi: Remove unused
 iosf_mbi_unregister_pmic_bus_access_notifier()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241225175010.91783-1-linux@treblig.org>
References: <20241225175010.91783-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174353299389.14745.950743351956667262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d0ebf4c7eb91fe73981d5250b50e9d22db8fb946
Gitweb:        https://git.kernel.org/tip/d0ebf4c7eb91fe73981d5250b50e9d22db8fb946
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Wed, 25 Dec 2024 17:50:10 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 20:31:39 +02:00

x86/platform/iosf_mbi: Remove unused iosf_mbi_unregister_pmic_bus_access_notifier()

The last use of iosf_mbi_unregister_pmic_bus_access_notifier() was
removed in 2017 by:

  a5266db4d314 ("drm/i915: Acquire PUNIT->PMIC bus for intel_uncore_forcewake_reset()")

Remove it.

(Note that the '_unlocked' version is still used.)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Link: https://lore.kernel.org/r/20241225175010.91783-1-linux@treblig.org
---
 arch/x86/include/asm/iosf_mbi.h      |  7 -------
 arch/x86/platform/intel/iosf_mbi.c   | 13 -------------
 drivers/gpu/drm/i915/i915_iosf_mbi.h |  6 ------
 3 files changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index af7541c..8ace655 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -168,13 +168,6 @@ void iosf_mbi_unblock_punit_i2c_access(void);
 int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb);
 
 /**
- * iosf_mbi_register_pmic_bus_access_notifier - Unregister PMIC bus notifier
- *
- * @nb: notifier_block to unregister
- */
-int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb);
-
-/**
  * iosf_mbi_unregister_pmic_bus_access_notifier_unlocked - Unregister PMIC bus
  *                                                         notifier, unlocked
  *
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index c81cea2..40ae94d 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -422,19 +422,6 @@ int iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(
 }
 EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier_unlocked);
 
-int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
-{
-	int ret;
-
-	/* Wait for the bus to go inactive before unregistering */
-	iosf_mbi_punit_acquire();
-	ret = iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(nb);
-	iosf_mbi_punit_release();
-
-	return ret;
-}
-EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier);
-
 void iosf_mbi_assert_punit_acquired(void)
 {
 	WARN_ON(iosf_mbi_pmic_punit_access_count == 0);
diff --git a/drivers/gpu/drm/i915/i915_iosf_mbi.h b/drivers/gpu/drm/i915/i915_iosf_mbi.h
index 8f81b76..317075d 100644
--- a/drivers/gpu/drm/i915/i915_iosf_mbi.h
+++ b/drivers/gpu/drm/i915/i915_iosf_mbi.h
@@ -31,12 +31,6 @@ iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(struct notifier_block *nb)
 {
 	return 0;
 }
-
-static inline
-int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
-{
-	return 0;
-}
 #endif
 
 #endif /* __I915_IOSF_MBI_H__ */

