Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733A5358114
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Apr 2021 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHKst (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Apr 2021 06:48:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHKsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Apr 2021 06:48:43 -0400
Date:   Thu, 08 Apr 2021 10:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617878910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IUq4vRGagIn46c9cW1IleNO1Bt9TPBPMXqjDwpoSVY=;
        b=m4hGOaQKQCjacGhEKratUgrnMw+Ht0ypLy/Hx5a1Hft57mL8MNJp9BPf209IJn4zE0Qcga
        VEmL0Eu0EK9onvkM3CNssTwZ+KS+G/5JbhD2q9oKf7O1/YXNm1vqpNONeYRFjzr0AnUy5S
        hy2R6MBIraOD5AajonWOdIum+Qi+39u5293r2uBAkyZKu+Jv6mVzD9s9J5BmICv/PbZ01N
        cNRKYjmPwdbO5fCGWZoT9kxtX0pID+W2jS4klTIuH2tUliYb9SMB6Njl+pQsqr0362eh20
        VH0eZDagJAPpaoMhmM9FJKuqq7Lv9lVmHkGi3usAmqRNqd4j19Vjrc20BvRqew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617878910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IUq4vRGagIn46c9cW1IleNO1Bt9TPBPMXqjDwpoSVY=;
        b=vRidT/SyKd5zo0ZjWrsclrFDypdndtcWSZWk8AFhNcVT+HGrtjTGOit0ZX50NVIOQf8HG+
        azzd5wkRGWUzKOBg==
From:   "tip-bot2 for Zhao Xuehui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Make locally used functions static
Cc:     Zhao Xuehui <zhaoxuehui1@huawei.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408095218.152264-1-zhaoxuehui1@huawei.com>
References: <20210408095218.152264-1-zhaoxuehui1@huawei.com>
MIME-Version: 1.0
Message-ID: <161787890998.29796.15716124525771113183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3e7bbe15ed84e3baa7dfab3aebed3a06fd39b806
Gitweb:        https://git.kernel.org/tip/3e7bbe15ed84e3baa7dfab3aebed3a06fd39b806
Author:        Zhao Xuehui <zhaoxuehui1@huawei.com>
AuthorDate:    Thu, 08 Apr 2021 17:52:18 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 08 Apr 2021 11:57:40 +02:00

x86/msr: Make locally used functions static

The functions msr_read() and msr_write() are not used outside of msr.c,
make them static.

 [ bp: Massage commit message. ]

Signed-off-by: Zhao Xuehui <zhaoxuehui1@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210408095218.152264-1-zhaoxuehui1@huawei.com
---
 arch/x86/lib/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 3bd905e..b09cd2a 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL(msrs_free);
  * argument @m.
  *
  */
-int msr_read(u32 msr, struct msr *m)
+static int msr_read(u32 msr, struct msr *m)
 {
 	int err;
 	u64 val;
@@ -54,7 +54,7 @@ int msr_read(u32 msr, struct msr *m)
  * @msr: MSR to write
  * @m: value to write
  */
-int msr_write(u32 msr, struct msr *m)
+static int msr_write(u32 msr, struct msr *m)
 {
 	return wrmsrl_safe(msr, m->q);
 }
