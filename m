Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4546826A065
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Sep 2020 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOIJI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Sep 2020 04:09:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOIHy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Sep 2020 04:07:54 -0400
Date:   Tue, 15 Sep 2020 08:07:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600157272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tAluLr+hpcUW2KTiV7mUpAEJ4g/emUKb1LOH131BW0=;
        b=MwlNkD4I5JhQqf/0psL3bq1bCr5hjazHBcHm0PLo4urMkhVc+KpbqSnY5XXMvkOR7TwESJ
        R/J0bG96hMoIshetnp5qoA7UtxgZ6eFoGKqPWbGLZu7/8tpH47RIKlPMapiG9FVWyI1RKv
        DNPhj5BasIEM2bioVKOmR9TRJEVF1fl8NXjDX2h8G+I2jHFsMiyCfjNPXP7Tfj9O7aksVc
        /kP+qiJ96kda9SGjgDL2fvn6QKBm/Z8orPeIpDt0buIguerBqgncyzZb6rEfIii/jg/CTh
        IryDvI4BZVMqsMKRO2jp8JlqDlN+gJy4RwCEzgPimxU1vdAvPEulsGWkGQpD+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600157272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tAluLr+hpcUW2KTiV7mUpAEJ4g/emUKb1LOH131BW0=;
        b=HUB6mMNPfG+UhllbD5asGr/MXLztplujnjcJN4NH/vMzAvsBGGBmC8VIRNRa3RzpEWDvAW
        6ZX7v7AXupEoY8CA==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/dev-mcelog: Do not update kflags on AMD systems
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <160015727115.15536.4953630545422945759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     dc0592b73715c8e84ad8ebbc50c6057d5e203aac
Gitweb:        https://git.kernel.org/tip/dc0592b73715c8e84ad8ebbc50c6057d5e203aac
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Thu, 03 Sep 2020 18:45:31 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Sep 2020 10:04:51 +02:00

x86/mce/dev-mcelog: Do not update kflags on AMD systems

The mcelog utility is not commonly used on AMD systems. Therefore,
errors logged only by the dev_mce_log() notifier will be missed. This
may occur if the EDAC modules are not loaded, in which case it's
preferable to print the error record by the default notifier.

However, the mce->kflags set by dev_mce_log() notifier makes the
default notifier skip over the errors assuming they are processed by
dev_mce_log().

Do not update kflags in the dev_mce_log() notifier on AMD systems.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 03e5105..100fbee 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -67,7 +67,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
-	mce->kflags |= MCE_HANDLED_MCELOG;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		mce->kflags |= MCE_HANDLED_MCELOG;
+
 	return NOTIFY_OK;
 }
 
