Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C07141D5F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 19 Jan 2020 11:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgASKky (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 19 Jan 2020 05:40:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60036 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgASKkx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 19 Jan 2020 05:40:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1it80c-0001fU-5X; Sun, 19 Jan 2020 11:40:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C80821C0315;
        Sun, 19 Jan 2020 11:40:45 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:40:45 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] ASoC: Intel: Skylake: Explicitly include
 linux/io.h for virt_to_phys()
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126165417.22423-10-sean.j.christopherson@intel.com>
References: <20191126165417.22423-10-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157943044560.396.11643987994795560623.tip-bot2@tip-bot2>
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

Commit-ID:     321354ba6883b5151fd283dc14fb29280e1fbd2e
Gitweb:        https://git.kernel.org/tip/321354ba6883b5151fd283dc14fb29280e1fbd2e
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 26 Nov 2019 08:54:14 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:15:48 +01:00

ASoC: Intel: Skylake: Explicitly include linux/io.h for virt_to_phys()

Through a labyrinthian sequence of includes, usage of virt_to_phys() is
dependent on the include of asm/io.h in x86's asm/realmode.h, which is
included in x86's asm/acpi.h and thus by linux/acpi.h.  Explicitly
include linux/io.h to break the dependency on realmode.h so that a
future patch can remove the realmode.h include from acpi.h without
breaking the build.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lkml.kernel.org/r/20191126165417.22423-10-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 5a2c35f..36f697c 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include "../common/sst-dsp.h"
