Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F6292C44
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgJSRCm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgJSRCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D1C0613CE;
        Mon, 19 Oct 2020 10:02:42 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/IOLDsjihFVDuq1Ebpf90k6Je2L76E31rtQL2FrryY=;
        b=BDBhsoRBNyNFMydb+UFgh2A99VtWw71nzA0izmrIiuep20WVolcQUxm7fj87dgSCxWA1CT
        tCTP3Rxtiy2im+aktxREmj0Ew1TfzQtKh5Ilf+kionMSHKQxeuiNyJrKa7KqODqv2swZd3
        po6kjLLJPQro+VuVeY9vXfgjzYheSvEck0tSUHDFWkcausVmQt8KMeBFG8ysDqYVLjK6ut
        IexHFG4bLEKFXTNEHPjcarvabjw/itCZwIrvqat7A7J8L1W0s69ySU0iuQqxeZPptKf+0c
        z20FgoY/RWfOAy6fjpqwG6KU+G3Yp1ttCYT1vmpn+PYaN9Sr9TNxzcXQPLl+Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/IOLDsjihFVDuq1Ebpf90k6Je2L76E31rtQL2FrryY=;
        b=l1Nag11Bd98PPJMkHsKtikypXH+Rpmh/f6VQ/ZVUNpye2MGL6lGi/CZ/MvMkxge3dcrvgn
        I9TYUAA/oEEDNZAQ==
From:   "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] Linux 5.9.1
Cc:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201016090437.170032996@linuxfoundation.org>
References: <20201016090437.170032996@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <160312695952.7002.3938172860461198423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     213f323329f1567e09f85ddb54cfb80769340b50
Gitweb:        https://git.kernel.org/tip/213f323329f1567e09f85ddb54cfb80769340b50
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Sat, 17 Oct 2020 08:31:22 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:22 +02:00

Linux 5.9.1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20201016090437.170032996@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 51540b2..d600b38 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 9
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
