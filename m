Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A4249DF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgHSMdh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 08:33:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39024 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgHSMdO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:14 -0400
Date:   Wed, 19 Aug 2020 12:33:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSYH8UGdj1f61R0KtIe765d1bB1D8LF4L63dxPDF0+U=;
        b=eXR2tjKLHRPArAECAnuX+gH2PFo6ff5oIM6aESXn/+568gW9mV7bcPzDC1Zdvc3pYG5nr7
        FSotx4k679g+Ux9e5sGkxrpJmCN0w1IdcYt/pwTz6MPyF5QmHpKnVr8H0a/sU3iFZVu5ys
        huDwjvxkhbT/hxGGYVp8BHFtZaqX8EdkDgILr5pnjW9ihDAAb4WR/3+JWmGTnr/3Ud+P0/
        QDjT71DCBxHx6Sbze8WyeDTndQvD4FqQpNE0IGjDbrxiAGaSaALHsJZ0e1EK2GHW68xSvT
        3jUHijRV0loacgEY4nxoUzezRmXbdqjfnsQUavbP+o1WQmEx6TEkVYS+OkZFGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSYH8UGdj1f61R0KtIe765d1bB1D8LF4L63dxPDF0+U=;
        b=ESOIyo5ZEJnF3pXV9+8Yv5PIJ9/Dn+RgOq7UYu1+SmLmh35cuzdAt+20uYKFE0mQ+5Q0eM
        /4otvK+M1VRVDtCA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Include pid.h
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-6-james.morse@arm.com>
References: <20200708163929.2783-6-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039111.3192.590146678481310707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a21a4391f20c0ab45db452e22bc3e8afe8b36e46
Gitweb:        https://git.kernel.org/tip/a21a4391f20c0ab45db452e22bc3e8afe8b36e46
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:24 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 17:06:15 +02:00

x86/resctrl: Include pid.h

We are about to disturb the header soup. This header uses struct pid
and struct pid_namespace. Include their header.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-6-james.morse@arm.com
---
 include/linux/resctrl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index daf5cf6..9b05af9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/pid.h>
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
