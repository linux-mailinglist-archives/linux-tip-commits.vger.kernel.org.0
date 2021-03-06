Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFF32FA66
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCFMBN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhCFMBH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:01:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF60BC06174A;
        Sat,  6 Mar 2021 04:01:06 -0800 (PST)
Date:   Sat, 06 Mar 2021 12:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MNa7PtVDOhipEBQKw5XetEFY7BvEAR17MKEeSV449I=;
        b=jakS0Bhglk5Diih6AsOWefX/DElpFh04/nEz26hVo/HTCd3ndutPocHWGhtH9BHfznVLLv
        Rq47B8+nLgRfagfHpGzoeJKT0A5vZEcaSQW+GVzoidBMY39f6N41DmyUZb4UCmRQndTQ7V
        kbwU4bFit9l/DMkwRUZPQ04FX9en2h+sSwx8rDpQBz7COBMOLzFjvYmE+YVNwve2chFbVL
        x0v5hYU6fVzwp/GOKZZZJFDLkXT9g+FDO24B570FoJtztEjSyXcYM4pTFr0G9nNZ97nogJ
        IgU+csC0PYd7Xpv4ullE84gr1ZT/nlyjBzxDFJdw6x92godwHD7fqRJX3am/Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MNa7PtVDOhipEBQKw5XetEFY7BvEAR17MKEeSV449I=;
        b=q67GrrGjr+armGqDzfViV6jig4MRMG0y+PmEopM2suihTEa2xr2Lul0WwcRmTqZSpI0qQp
        +PaoeO3xzmzcVEAg==
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
Message-ID: <161503206505.398.71755286884944348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     e93d757c3f33c8a09f4aae579da4dc4500707471
Gitweb:        https://git.kernel.org/tip/e93d757c3f33c8a09f4aae579da4dc4500707471
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Fri, 19 Feb 2021 12:28:52 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 12:28:35 +01:00

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
