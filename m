Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B78141D60
	for <lists+linux-tip-commits@lfdr.de>; Sun, 19 Jan 2020 11:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgASKky (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 19 Jan 2020 05:40:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgASKky (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 19 Jan 2020 05:40:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1it80b-0001fR-UF; Sun, 19 Jan 2020 11:40:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7DF671C1A1B;
        Sun, 19 Jan 2020 11:40:45 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:40:45 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/ACPI/sleep: Remove an unnecessary include of
 asm/realmode.h
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126165417.22423-11-sean.j.christopherson@intel.com>
References: <20191126165417.22423-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157943044530.396.4574110491392220728.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     cb28909525acdd1a89c5b2de761eaf2f788c0057
Gitweb:        https://git.kernel.org/tip/cb28909525acdd1a89c5b2de761eaf2f788c0057
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 26 Nov 2019 08:54:15 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:15:48 +01:00

x86/ACPI/sleep: Remove an unnecessary include of asm/realmode.h

None of the declarations in x86's acpi/sleep.h are in any way dependent
on the real mode boot code.  Remove sleep.h's include of asm/realmode.h
to limit the dependencies on realmode.h to code that actually interacts
with the boot code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20191126165417.22423-11-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/acpi/sleep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index fbb60ca..d06c207 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -3,7 +3,7 @@
  *	Variables and functions used by the code in sleep.c
  */
 
-#include <asm/realmode.h>
+#include <linux/linkage.h>
 
 extern unsigned long saved_video_mode;
 extern long saved_magic;
