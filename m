Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146B12B99B8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgKSRkN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 12:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgKSRkM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 12:40:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549AC0613CF;
        Thu, 19 Nov 2020 09:40:12 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:40:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605807610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EUwIaTvhKlhY/ECgSJd6ijmLm0pgbclTSXiBzlh9SU=;
        b=Elhl4/DtU3N1aQ4FpY9dwmuTN3hBCBxgWSFE6AIuxH/iUyJ74Ka83RrGDLzyKaP77F6OD1
        k6NrMy4SCQs7T287vxoumi5R1Zqs0iTsBIkaupnuNVPiLrWfcjimWSzTnprvAuiP0B9cZx
        dSPAT7vjCII4TSdaRn4pxNZeswrSnRWDi/bfUBBpV8EVaSeO/UEbeta77sAnRF3H2c2Tw/
        Orx2+nWzMWMpD/mM3efAKOt8Zc1RghooRqRsW5uzhgsBHW1BV973BGsb86P7gLvDj46lko
        kyfL02f0VD45J9DHXwFQE1mK4D+dfS1fHyw1vZwWeNEc8ICZJqzSqu6pTb+DuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605807610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EUwIaTvhKlhY/ECgSJd6ijmLm0pgbclTSXiBzlh9SU=;
        b=u11FErYZJrMx4VQAQKlzHoge0yDkqCzjNKL+3oT+ChT35+RXwzaCzG/NQCa6lIkhRsLceX
        45ie+4bR/XUXGiAQ==
From:   "tip-bot2 for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Constify kernfs_ops
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110230228.801785-1-rikard.falkeborn@gmail.com>
References: <20201110230228.801785-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <160580760905.11244.68091296565115435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2002d2951398317d0f46e64ae6d8dd58ed541c6d
Gitweb:        https://git.kernel.org/tip/2002d2951398317d0f46e64ae6d8dd58ed541c6d
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Wed, 11 Nov 2020 00:02:28 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 18:23:45 +01:00

x86/resctrl: Constify kernfs_ops

The only usage of the kf_ops field in the rftype struct is to pass
it as argument to __kernfs_create_file(), which accepts a pointer to
const. Make it a pointer to const. This makes it possible to make
rdtgroup_kf_single_ops and kf_mondata_ops const, which allows the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20201110230228.801785-1-rikard.falkeborn@gmail.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6cb068f..5540b02 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -264,7 +264,7 @@ void __exit rdtgroup_exit(void);
 struct rftype {
 	char			*name;
 	umode_t			mode;
-	struct kernfs_ops	*kf_ops;
+	const struct kernfs_ops	*kf_ops;
 	unsigned long		flags;
 	unsigned long		fflags;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index af323e2..78dcbb8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -240,13 +240,13 @@ static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
 	return -EINVAL;
 }
 
-static struct kernfs_ops rdtgroup_kf_single_ops = {
+static const struct kernfs_ops rdtgroup_kf_single_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.write			= rdtgroup_file_write,
 	.seq_show		= rdtgroup_seqfile_show,
 };
 
-static struct kernfs_ops kf_mondata_ops = {
+static const struct kernfs_ops kf_mondata_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.seq_show		= rdtgroup_mondata_show,
 };
