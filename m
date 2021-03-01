Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE6327C1C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhCAK3Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhCAK3J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:29:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086AEC06174A;
        Mon,  1 Mar 2021 02:28:29 -0800 (PST)
Date:   Mon, 01 Mar 2021 10:28:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614594507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBEutZAcaqNmgkIlf5JXEYggQE0NqRGs7D3iN5T9Kok=;
        b=Wys15cimkMu3s3W7ZMCYduex0fuS4WsCewfB+SxICxnL17kh04z2Ei55eDiQ/8w77i5OOf
        3P70RJ4S6DdCbd3rX8JMynNCN637lxRc7z1SV6m5ge3tgvZjQLW5pmoQipGyprYAS56yCF
        /5DjmaW6RDxGsL7e6FTpnu6nimK57i8sGOyDpyIM59uRSZ+mKE9GyZRdF8XRo4RjQOIMNs
        yiZHMZ8y0RBdboo/pMbBOL0OioQvQ8AH/Vfzod1yTdKzvPruSYDJmFDjQn1q94xZfmawDi
        Fi9XQQGAhh7kYpUuU1jryx1WRW8YZkhYfiUfNQE+CTn5sIYiyS4WVA1QMZFPow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614594507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBEutZAcaqNmgkIlf5JXEYggQE0NqRGs7D3iN5T9Kok=;
        b=xcmfhSmHKGWL/oR5q+cjaisJOCBS/czHpuzT2y82Nh6Yx+nnbm80WuTWBNt4SjR25HxzdX
        lbnfiZ2mJ+cefICg==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Fix indentation warning in
 Documentation/ABI/testing/sysfs-firmware-sgi_uv
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Mike Travis <mike.travis@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210219182852.385297-1-justin.ernst@hpe.com>
References: <20210219182852.385297-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <161459450674.20312.3909036140649624505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     2430915f8291212f2bd2155176b817c34a18a2b1
Gitweb:        https://git.kernel.org/tip/2430915f8291212f2bd2155176b817c34a18a2b1
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Fri, 19 Feb 2021 12:28:52 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 01 Mar 2021 11:14:25 +01:00

x86/platform/uv: Fix indentation warning in Documentation/ABI/testing/sysfs-firmware-sgi_uv

Commit

  c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")

misplaced the first line of a codeblock section, causing the reported
warning message:

  Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.

Move the misplaced line below the required blank line to remove the
warning message.

Fixes: c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Mike Travis <mike.travis@hpe.com>
Link: https://lkml.kernel.org/r/20210219182852.385297-1-justin.ernst@hpe.com
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 637c668..12ed843 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -39,8 +39,8 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version::
-			"0.*" = Hubless UV ('*' is subtype)
 
+			"0.*" = Hubless UV ('*' is subtype)
 			"3.0" = UV2
 			"5.0" = UV3
 			"7.0" = UV4
