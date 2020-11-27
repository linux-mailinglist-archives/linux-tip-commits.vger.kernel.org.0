Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A92C6643
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Nov 2020 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgK0NGd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Nov 2020 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgK0NGd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Nov 2020 08:06:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B7C0613D1;
        Fri, 27 Nov 2020 05:06:33 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:06:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606482388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evNa31gSXrx3TIvpxrIqlaWoeOcFTpBJUhUxOpWb3DE=;
        b=XTREr6ab1FJYc5EttVQ+4vY3kj7232sP2NsjZMuoynzR40DKUQyMvrBDMcfX0KxrUM2frz
        W+5A7Aw6tzLjwyxCVOcJXP3kH4xbD2QvdVEqWgcDTeBC4uOsxRqap9MWv5t47B8a84vv2y
        XiAVaG67M/mtH+aHOEi95xzqtTL2NuBeXILJGm9JcwpF2FGdJwKM+qn92AC2NSi59Eg5qj
        ftGC0Sy/idDGD1Xab4/3EcncyD/+m63Bjy9LxJBo/QqP4QsC7twMhnn2NXeR6XwnB2pmhH
        o7IJV3DxIg9rRvbXtnbgpWEdcO+lZF00u2gfZ/+cPjIMSjlPDxSlwUP/tDXHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606482388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evNa31gSXrx3TIvpxrIqlaWoeOcFTpBJUhUxOpWb3DE=;
        b=rJLPm6LFo/gbSw71d4YGXFJus/WJSvVMDJyE3TRlAWlQscAx4xZuUBQlOW5Gjku7Js7rb4
        qKL5+v/2uFbJEgAw==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/PCI: Make a kernel-doc comment a normal one
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605257895-5536-5-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160648238740.3364.16081084412087294713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     638920a66a17c8e1f4415cbab0d49dc4a344c2a7
Gitweb:        https://git.kernel.org/tip/638920a66a17c8e1f4415cbab0d49dc4a344c2a7
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 16:58:14 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 27 Nov 2020 13:43:09 +01:00

x86/PCI: Make a kernel-doc comment a normal one

The comment is using kernel-doc markup but that comment isn't a
kernel-doc comment so make it a normal one to avoid:

  arch/x86/pci/i386.c:373: warning: Function parameter or member \
	  'pcibios_assign_resources' not described in 'fs_initcall'

 [ bp: Massage and fixup comment while at it. ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1605257895-5536-5-git-send-email-alex.shi@linux.alibaba.com
---
 arch/x86/pci/i386.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index fa855bb..f2f4a5d 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -366,9 +366,9 @@ static int __init pcibios_assign_resources(void)
 	return 0;
 }
 
-/**
- * called in fs_initcall (one below subsys_initcall),
- * give a chance for motherboard reserve resources
+/*
+ * This is an fs_initcall (one below subsys_initcall) in order to reserve
+ * resources properly.
  */
 fs_initcall(pcibios_assign_resources);
 
