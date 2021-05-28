Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE13944F8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 May 2021 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhE1P0r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 28 May 2021 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhE1P0q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 28 May 2021 11:26:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF93C061574;
        Fri, 28 May 2021 08:25:12 -0700 (PDT)
Date:   Fri, 28 May 2021 15:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622215510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVD/32lu0e2EW4SPDT8da31LdfxPfv1H02tuNXdHyO0=;
        b=v8iDPIpbM6OD0A9e+yELm6LRO4yUPt3m9jHJpTXkZPILg7TPwYEOhdwcM+SXRpOjhnVPAq
        OMqmfNuKQ3jWG0co4/EhyukBNbcL1g9CfBF406AjoCtYnx8idMoRRcxgk6I9AwRm879Dbb
        i8V5HEXMy3+KrNjgz3GRCg1UKiN4o3ne1di+ZiQjJPuCNYT/CUj7/eBB3XAyzVi6p7KBE0
        PL/7az6+PuQnPG1vs3fW3NBiGxmMJXsWmlFWufe3pBEaYwAIjRPP6E6+IAHbwdP35limA4
        Kl9PgxsH9mmNsecRh5TJdPkSZZOwYI/q2vRDNnylIuby2yfHJ2HQwR/KjqJarA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622215510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVD/32lu0e2EW4SPDT8da31LdfxPfv1H02tuNXdHyO0=;
        b=56OqdVwQTYEafpcjJJV9OujGdihJyIDtE9squ8DyqOkO/o9zs9a1mA3+qVJ5hv1BBTdYje
        4GOCdybELGZGYwDA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Include a MCi_MISC value in faked mce logs
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210527222846.931851-1-tony.luck@intel.com>
References: <20210527222846.931851-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <162221550967.29796.6170052716634166865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     40cd0aae5957ec175b73dc17dce6079d33fa74f6
Gitweb:        https://git.kernel.org/tip/40cd0aae5957ec175b73dc17dce6079d33fa74f6
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 27 May 2021 15:28:46 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 28 May 2021 16:57:16 +02:00

x86/mce: Include a MCi_MISC value in faked mce logs

When BIOS reports memory errors to Linux using the ACPI/APEI
error reporting method Linux creates a "struct mce" to pass
to the normal reporting code path.

The constructed record doesn't include a value for the "misc"
field of the structure, and so mce_usable_address() says this
record doesn't include a valid address.

Net result is that functions like uc_decode_notifier() will
just ignore this record instead of taking action to offline
a page.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210527222846.931851-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/apei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b58b853..0e3ae64 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -36,7 +36,8 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
-	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
+	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
