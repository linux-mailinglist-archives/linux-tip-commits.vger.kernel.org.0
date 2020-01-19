Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908CC141D58
	for <lists+linux-tip-commits@lfdr.de>; Sun, 19 Jan 2020 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgASKlH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 19 Jan 2020 05:41:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgASKk4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 19 Jan 2020 05:40:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1it80j-0001hH-2G; Sun, 19 Jan 2020 11:40:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AC5771C1A1C;
        Sun, 19 Jan 2020 11:40:47 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:40:47 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/boot: Explicitly include realmode.h to handle
 RM reservations
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126165417.22423-3-sean.j.christopherson@intel.com>
References: <20191126165417.22423-3-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157943044751.396.1039007415959241549.tip-bot2@tip-bot2>
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

Commit-ID:     ca947b72e1dec3a000190733f7e0be38fe73eaae
Gitweb:        https://git.kernel.org/tip/ca947b72e1dec3a000190733f7e0be38fe73eaae
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 26 Nov 2019 08:54:07 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:15:47 +01:00

x86/boot: Explicitly include realmode.h to handle RM reservations

Explicitly include asm/realmode.h, which provides reserve_real_mode(),
instead of picking it up by an indirect include of asm/acpi.h.  acpi.h
will soon stop including realmode.h so that changing realmode.h doesn't
require a full kernel rebuild.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/r/20191126165417.22423-3-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b5ac993..a584983 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -35,6 +35,7 @@
 #include <asm/kaslr.h>
 #include <asm/mce.h>
 #include <asm/mtrr.h>
+#include <asm/realmode.h>
 #include <asm/olpc_ofw.h>
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
