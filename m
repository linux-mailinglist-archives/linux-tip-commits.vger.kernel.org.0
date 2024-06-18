Return-Path: <linux-tip-commits+bounces-1446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881290D48A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A942E28563A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8E16B388;
	Tue, 18 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAi+QEcR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCxfG6W1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0416A94C;
	Tue, 18 Jun 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719309; cv=none; b=IVcga+RyPepckDjUfsz2HWUpoZKBqPvVbOdFZdkf0QenjNt0wkxwQWUR5ulbwWyhRGyCrZpUg4ev3ZC6HotEwB87DrfaICSVfSUHYCVXecrR7TFqn0uT1f00xvsKpBzIbt34EgLl4s+AY22B29ekWsjZxUNAgOCUwKNoSy/5l+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719309; c=relaxed/simple;
	bh=8de1Nd38MM5wN7T6XMaiBtWMZBF1JbpceyfCt2HJdRE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ux8mi3i1+xdKrsHZPc9BvdhxA3VenPeSRU/E6HmN+S6s72SbtHBzb7usUf4q/iBPFp7XwDiHFIMivq3WRIDa/HOzIuJe8KeGFMNiePNw/MGz4Ih4vCXzqdkEdqj1yIwZRuYkzo05Sm7qlC/uWU/DEG3pxMWyCeDMLeCbI8TAT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAi+QEcR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCxfG6W1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK7h0C0KVTLZxO68wwzEK/AcQDwtH6VNHjwCjSnaAu0=;
	b=fAi+QEcR6U6OQzKGvgxVIM9K8rP0uf+7D6n46x/gVOydcZPVVmbGtFu+lnzWzIShaX+W2d
	aEfeoI2eOpeAmgaEKc9pXybQ0uHU8LjuQ+KW2vAOHzMOeFHsl3Ucs+JKDVTgUWZnGsWrXl
	zXTHV/qVK/54w3glHPoRLRXlxqwCNhsNFNEHFXKqI9DAoWCOvdWX8dZh4rLoJBg3Qjfuqz
	lD1rRCBQ5R+A6rux6jlEaGANa4BwFKg+Phx+r08ZbBv98ZO6/7XCicvnDWPTdIHjeeRaJ5
	kBgZc5D17yOaCFgDQs7srx7Xk48fJDRdsGN+Pbbk6b5QJs0y55V86FcY5FhZzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK7h0C0KVTLZxO68wwzEK/AcQDwtH6VNHjwCjSnaAu0=;
	b=bCxfG6W1hSadlRqwM5cXGsc6GoElbm3jWyxMcvd9wQ0UO4tt/GWZ9zUngBSriDopPT+DuB
	DDcPZHuVdWqZxFCg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cc] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-20-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-20-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871929790.10875.2508282628662679382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     16df35946120fca2346c415fae429c821391eef8
Gitweb:        https://git.kernel.org/tip/16df35946120fca2346c415fae429c821391eef8
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:59:04 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:28 +02:00

ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed

When MADT is parsed, print MULTIPROC_WAKEUP information:

  ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])

This debug information will be very helpful during bringup.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-20-kirill.shutemov@linux.intel.com
---
 drivers/acpi/tables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b976e5f..9e1b01c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p =
+				(struct acpi_madt_multiproc_wakeup *)header;
+			u64 reset_vector = 0;
+
+			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
+				reset_vector = p->reset_vector;
+
+			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
+				 p->version, p->mailbox_address, reset_vector);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_CORE_PIC:
 		{
 			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;

