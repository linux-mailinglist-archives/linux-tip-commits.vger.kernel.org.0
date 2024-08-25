Return-Path: <linux-tip-commits+bounces-2109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9195E35D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A4A1C20AD8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DB15F41B;
	Sun, 25 Aug 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3J29lbx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVkcKPYD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177791547FF;
	Sun, 25 Aug 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589437; cv=none; b=iDsx/TJAKQ7fYetTinYEHusVHDUfrQS6PabIbnhdWX4CW7+ifr5lqnjkZAM31AQKMNw29VfAoGORQe+o2qGGL5C2R4an3U3q/c0vxFHbYyKYGIvl+pneT9DWD5GBuuFgeO6c9bsYWT8gk1ZGNfrnesrjPmeaDWZr5vTaXq8lflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589437; c=relaxed/simple;
	bh=GM+Sjju/B2IyJuB4R01FSOnZw6sXllUBBKRXQZfbIFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UdrN9m/+y005032RLCG9PmKaMir2ozvTeYvUmqxdOq4+8f8zkAm1xXnWGG0A9GCf9jQhrKyHtElKa8ciCz7t9znj+M0w5K2/oJJz5F0n79VtcBrubBwj8MNUei8rCJTCO3CnORLsK79FqktzMhraLzSQIWFXa2aPZe1n9mLPtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3J29lbx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVkcKPYD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy4TM17hHYleH6Z3EriDRBdVDs3XbjImvzMd/O5+v/A=;
	b=g3J29lbxnVgt+cBzNcHh8gBj3JjBLvM01r3Z17+RDUBJtoyaQTgV1A8QS4PL103vW3W4qQ
	+vFhEUDSNknXVuRy9/9V5ZjRdAxcsLIc3XmCnFQwYOmA4GGX06HO3Go4VePzAkL+0fVXYa
	i2FEa6OF4X8FehVf0L5x855zz6If75uwN9awPQZlBoV2lnca6gQzzd60rOFRYtvNS9qVWR
	aPhOPNM26vlgMm5cARUHHgy18CVacgjf53Wx+xIvC28uWufysPg4Gvxjp/ZSkYg0SpxTRc
	ssTOFoaLEIcSETnB15j0Pio20Z6zsS7apOBYJzhxi5t1PbkEeD0nK4djHuiNCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy4TM17hHYleH6Z3EriDRBdVDs3XbjImvzMd/O5+v/A=;
	b=AVkcKPYDOIf3jz+kZOrUameHKWtVvPgt6cpcZxVCXy2LUBgCgBzVmtpJPjL/5WWvxKYiuw
	x824CqmFutRC+KAQ==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu_entry_area: Annotate
 percpu_setup_exception_stacks() as __init
Cc: Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240822-x86-percpu=5Fsetup=5Fexception=5Fstacks-i?=
 =?utf-8?q?nit-v1-1-57c5921b8209=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20240822-x86-percpu=5Fsetup=5Fexception=5Fstacks-in?=
 =?utf-8?q?it-v1-1-57c5921b8209=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943260.2215.14869797075024485238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     decb9ac4a9739c16e228f7b2918bfdca34cc89a9
Gitweb:        https://git.kernel.org/tip/decb9ac4a9739c16e228f7b2918bfdca34cc89a9
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 22 Aug 2024 17:18:08 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:38 +02:00

x86/cpu_entry_area: Annotate percpu_setup_exception_stacks() as __init

After a recent LLVM change that deduces __cold on functions that only call
cold code (such as __init functions), there is a section mismatch warning
from percpu_setup_exception_stacks(), which got moved to .text.unlikely. as
a result of that optimization:

  WARNING: modpost: vmlinux: section mismatch in reference:
  percpu_setup_exception_stacks+0x3a (section: .text.unlikely.) ->
  cea_map_percpu_pages (section: .init.text)

Drop the inline keyword, which does not guarantee inlining, and replace it
with __init, as percpu_setup_exception_stacks() is only called from __init
code, which clears up the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822-x86-percpu_setup_exception_stacks-init-v1-1-57c5921b8209@kernel.org

---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index e91500a..575f863 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -164,7 +164,7 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	}
 }
 #else
-static inline void percpu_setup_exception_stacks(unsigned int cpu)
+static void __init percpu_setup_exception_stacks(unsigned int cpu)
 {
 	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
 

