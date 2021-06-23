Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1593B1B31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFWNem (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 09:34:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhFWNeh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 09:34:37 -0400
Date:   Wed, 23 Jun 2021 13:32:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624455134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHk5sOOatpxgKTeeDjRn7/KDyn4XdfhGj02rsJfjugk=;
        b=bpR0VH6CtyjOSLTlTzi7I/uku6K56WzRg7PpPCVO5aRnc+vbtl1c5j0Irw/TMH3lcrmFsK
        xdTC/fCiJWTaySGgZoVDEsyDVdwrCkY3qBFKHY+2z/YrGRfQwr8l6JKS4E9RbwGUueTq+u
        isY3FSPKJh9itW1lhqvcY3yvv0JKGHHFAcFwxKnb2EpF/1kqsUvD9sNY5fYFFLkaxHVhhW
        rwPDN2tPNx5fniA4peQ3Rkh/zo632IqFSYgwa7NsgdlHrPBnVx4UyICgSufPHpgSlIV63Y
        yM+WEPBGGBREP/giA1EBkucWEaIDPqurHWRGf2ADwSO5UEQgRGNdxFLiF3isWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624455134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHk5sOOatpxgKTeeDjRn7/KDyn4XdfhGj02rsJfjugk=;
        b=B/dgmQaRSHfwxb5sWde5Zxw3YrAVjDuN0hkabteZb73IpcsPkoy6NedEBXHtYM42IFQYI/
        4H9uPFBUiNIYyoDg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Use "SEV: " prefix for messages from sev.c
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210622144825.27588-4-joro@8bytes.org>
References: <20210622144825.27588-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162445513336.395.16316436915627045107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f
Gitweb:        https://git.kernel.org/tip/8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 22 Jun 2021 16:48:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 11:56:18 +02:00

x86/sev: Use "SEV: " prefix for messages from sev.c

The source file has been renamed froms sev-es.c to sev.c, but the
messages are still prefixed with "SEV-ES: ". Change that to "SEV: " to
make it consistent.

Fixes: e759959fe3b8 ("x86/sev-es: Rename sev-es.{ch} to sev.{ch}")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210622144825.27588-4-joro@8bytes.org
---
 arch/x86/kernel/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 87a4b00..a6895e4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -7,7 +7,7 @@
  * Author: Joerg Roedel <jroedel@suse.de>
  */
 
-#define pr_fmt(fmt)	"SEV-ES: " fmt
+#define pr_fmt(fmt)	"SEV: " fmt
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
