Return-Path: <linux-tip-commits+bounces-1451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8290D498
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC7283F5F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C6B1A2FC5;
	Tue, 18 Jun 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGQBU/yO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Q3JUbRH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A316CD03;
	Tue, 18 Jun 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719313; cv=none; b=cC/RFaU50B1sg22b4PB9ZY4h4VJrD5njm0vlbBipr6zWVqS6L2wZN/yGJQgcLkFE+RMQ0SwUkgTimf2BH03yZAEHt40yCKQnoF8Gg0panX6vrWAy6xNFlX/ULnQQW0mObQI+MRuAVQY50UkenRjil07a73pPNZ0OajrxceaM0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719313; c=relaxed/simple;
	bh=u1frbaHGWjzLBHSXA3BXKK9Hqja+/d580Tp7fUn7518=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g0z0cgbjmGTEFi3azdwfZwvraDJIPsPKmkz59ztw90ANAbCG1cIj4DDPKg0jDx8SkKQQKcTJ51dOV5ItVChKfl823NioiMMFtuXCZCH4ybnmaHsfCz82JsQYpI2doWXApd8wWoZqltGTYerQeuZKTbq0rhC5hVGAtDry7gxf6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGQBU/yO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Q3JUbRH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkXsrRcH4s3oYeNAqGgzDUSRO9Ptw0QpT5nENImM2Lo=;
	b=eGQBU/yOwfluHRXuiQkeaZB41H4juIbwl/W3Yq4w9O+IwQUMj9daca+o+Uyc2D4TP4lryQ
	RAacX4103R4wQDq/qPH1DP7UB91Q6zQYN4XibOYwM0R0CYWYME3LJgJrLMu4kfbT+0L89N
	S7WJnsWAsDXwpOdRxXT3/G4U6eL4iloZJ7/mAKPUoHU94ap1Sx3vnMc/LcTy+GSVkKYkX7
	LUWcMcwKn6yhf10J3Kp6Fj9hDjqGJwBq9mr0BVzpRJMaRuoR96Q1RAMBqzVOtgl4DRtTev
	EbkjMMxU23LxLVYsEyAnChmAkqIehDzi6SFriuA/++ti16wzJl9THB7E1YkKLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkXsrRcH4s3oYeNAqGgzDUSRO9Ptw0QpT5nENImM2Lo=;
	b=2Q3JUbRHtepQOUD8JmNcpVz8VDgohlRpmsH3Vn74tnNBXEdeRnXKyhLOFB49EOvogCy2W2
	NxXFFQQsyr6YHOBw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/acpi: Rename fields in the
 acpi_madt_multiproc_wakeup structure
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kai Huang <kai.huang@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-15-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-15-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871929973.10875.15941098463748118730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     6630cbce7cd7785f76b1055f33a71199ef28510b
Gitweb:        https://git.kernel.org/tip/6630cbce7cd7785f76b1055f33a71199ef28510b
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:59 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:15 +02:00

x86/acpi: Rename fields in the acpi_madt_multiproc_wakeup structure

In order to support MADT wakeup structure version 1, provide more appropriate
names for the fields in the structure.

Rename 'mailbox_version' to 'version'. This field signifies the version of the
structure and the related protocols, rather than the version of the mailbox.
This field has not been utilized in the code thus far.

Rename 'base_address' to 'mailbox_address' to clarify the kind of address it
represents. In version 1, the structure includes the reset vector address. Clear
and distinct naming helps to prevent any confusion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-15-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 include/acpi/actbl2.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d222be8..004801b 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -75,7 +75,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
 	cpu_hotplug_disable_offlining();
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ae747c8..fa63362 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1194,9 +1194,9 @@ struct acpi_madt_generic_translator {
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-	u16 mailbox_version;
+	u16 version;
 	u32 reserved;		/* reserved - must be zero */
-	u64 base_address;
+	u64 mailbox_address;
 };
 
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032

