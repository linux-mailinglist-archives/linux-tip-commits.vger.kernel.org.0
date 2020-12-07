Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0E2D1D73
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgLGWiZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 17:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgLGWiZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 17:38:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3165AC061749;
        Mon,  7 Dec 2020 14:37:45 -0800 (PST)
Date:   Mon, 07 Dec 2020 22:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiWpngYQqA3mJsocQ433sIYBnMyXSWCQGbbHEOQ9Z34=;
        b=ol2RgoFwwI2s4oCAQPdJGoKYr5IqWVLXOO3eM8XhPjhbJOntohVrXQ6+DfCcyDdLdy3I0l
        ZSqoUCIxTlYv/dwK4hUuUzayD97iozsvViP0s9ttwCN3DRsfs2MiK2Bk1XOgYnICUNpyQw
        28LPL3t7x3ERtiujrum4xKJyUrf11dKSs8TmTd+xJ5agcpMFAak3kkk84zLXCuq2hrjdbA
        m6VNZjL4gEpsmKpEU7MxjuY5dt/eokNTan4nfmL/IsySRrbuJw5MfwAUvqPzq8WBY/MU3O
        PDJQPr/aIFdoSAXcqz3Y6CziUZG86oa68/aK1CSEf0iF/Kieik/y3lU3VYD3Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiWpngYQqA3mJsocQ433sIYBnMyXSWCQGbbHEOQ9Z34=;
        b=zdcvIqRfb9Nooj/FwZIrh4krswJPxMi66guvlZvWUKYY3vh8f0Jun5gYOCNrtjVDn9UEBp
        0R1SOM6zNc5xheDQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update sysfs documentation
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128034227.120869-6-mike.travis@hpe.com>
References: <20201128034227.120869-6-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160738066226.3364.16068740086522542201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2
Gitweb:        https://git.kernel.org/tip/c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 27 Nov 2020 21:42:27 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 21:19:20 +01:00

x86/platform/uv: Update sysfs documentation

Update sysfs documentation file to include moved /proc leaves.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201128034227.120869-6-mike.travis@hpe.com
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 16 ++++++++++++++++-
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 351b1f4..637c668 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -7,10 +7,25 @@ Description:
 
 		Under that directory are a number of read-only attributes::
 
+			archtype
+			hub_type
+			hubless
 			partition_id
 			coherence_id
 			uv_type
 
+		The archtype entry contains the UV architecture type that
+		is used to select arch-dependent addresses and features.
+		It can be set via the OEM_ID in the ACPI MADT table or by
+		UVsystab entry both passed from UV BIOS.
+
+		The hub_type entry is used to select the type of hub which is
+		similar to uv_type but encoded in a binary format.  Include
+		the file uv_hub.h to get the definitions.
+
+		The hubless entry basically is present and set only if there
+		is no hub.  In this case the hub_type entry is not present.
+
 		The partition_id entry contains the partition id.
 		UV systems can be partitioned into multiple physical
 		machines, which each partition running a unique copy
@@ -24,6 +39,7 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version::
+			"0.*" = Hubless UV ('*' is subtype)
 
 			"3.0" = UV2
 			"5.0" = UV3
