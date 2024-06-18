Return-Path: <linux-tip-commits+bounces-1462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4F90D4BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B9F1C22513
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CC1AAE05;
	Tue, 18 Jun 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQFfRtoM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4aU2ft1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD01A3BBE;
	Tue, 18 Jun 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719318; cv=none; b=pvgQdjCEMiJgsLlE0dawrG1ZW9/5sUYlE8qXq3PMONsDcm3JKIOFAbxCd5swkTszbkanUu16H6I58ja0qC5eKYSxio+B6LKRX46r3Yl3rc9XTB8bNNOxLVaMAsh/BMppEhF0LtRP/o3vfOztyr0rT/6Y74q6QHq6BgyLqLsTfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719318; c=relaxed/simple;
	bh=s4QufuVFAV/dp9Ag7/ajdIQudCv2ZLnSNAP7cmZhq1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X2JMNFkc1qxAbG9L9DAAyJbNn5sXAbnYOT+Vb8AOkvZAEAzNe++PiPJIHXefF1DoyO0TtfjKwHi4wT42M2gKfAnwhg7k2r2PJmMXrR7ObuX01J9ID+6lhhfBLzDQPem4JrKMjUfmAdcAz8vkJAGh2OB/189V8bDyXJD26iHLMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OQFfRtoM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4aU2ft1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsPrsDdspshAX8mdvYFpWVVZj64dKyuUoXTQJKP8xH0=;
	b=OQFfRtoMW+t1AJpUNCovysXqyGWq0Sp2yNnataxB66Ghrt9BF5JG4tW0gpwxqqAPQcQp7r
	OSCIjnkHZH33I4/Q0BhSUOdZ5a8QsnRjsiVInbHPHhDhKq4OPrh32nM8btKPQ10fcCIuv4
	6tYzbHV/SAp2/o3Pb/EKYZqlXtUJglYbHC7aXWa/TA5A+HID6FZ9X3s/jKBPBPEtTGHuDS
	GbSugGmiMrcwkrKvk5nkXWZCPy16BVlNcXHI4Pli9odLugD6+lAzPIBRRs9BOfp0Lw4sjZ
	mCT39Hg/YhBZcZXE1rY//nynCcKXlqAtkHMRRtiBwLR+5W7qV5ZApePbaKQqUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsPrsDdspshAX8mdvYFpWVVZj64dKyuUoXTQJKP8xH0=;
	b=T4aU2ft13OZpC3fcO1ddN6M4LHnILyA04OF2pkRjPV8/kMNWSHlbPimzDGK4EAjPkXwy/D
	tTvxEhGrzRCAqABg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cc] x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Kai Huang <kai.huang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-3-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930346.10875.13978180947702027470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     24dd05da8c7995cb2016b8f4da631c557aa6b40d
Gitweb:        https://git.kernel.org/tip/24dd05da8c7995cb2016b8f4da631c557aa6b40d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:47 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:28 +02:00

x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init

acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox are initialized once during
ACPI MADT init and never changed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-3-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 7f164d3..cf79ea6 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -6,10 +6,10 @@
 #include <asm/processor.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
+static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {

