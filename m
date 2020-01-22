Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAB144C28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jan 2020 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVG51 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jan 2020 01:57:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVG50 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jan 2020 01:57:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iu9x1-00034n-Au; Wed, 22 Jan 2020 07:57:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C14A61C1A0C;
        Wed, 22 Jan 2020 07:57:18 +0100 (CET)
Date:   Wed, 22 Jan 2020 06:57:18 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] objtool: Skip samples subdirectory
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <c4cb4ef635ec606454ab834cb49fc3e9381fb1b1.1579543924.git.jpoimboe@redhat.com>
References: <c4cb4ef635ec606454ab834cb49fc3e9381fb1b1.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <157967623849.396.5555831955649613132.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     8728497895794d1f207a836e02dae762ad175d56
Gitweb:        https://git.kernel.org/tip/8728497895794d1f207a836e02dae762ad175d56
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 20 Jan 2020 12:14:09 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Jan 2020 07:55:02 +01:00

objtool: Skip samples subdirectory

The code in the 'samples' subdirectory isn't part of the kernel, so
there's no need to validate it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/c4cb4ef635ec606454ab834cb49fc3e9381fb1b1.1579543924.git.jpoimboe@redhat.com
---
 samples/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Makefile b/samples/Makefile
index 5ce50ef..f8f847b 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux samples code
+OBJECT_FILES_NON_STANDARD := y
 
 obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+= binderfs/
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
