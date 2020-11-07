Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9B2AA463
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKGKSv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 05:18:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgKGKSu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 05:18:50 -0500
Date:   Sat, 07 Nov 2020 10:18:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604744325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM3mMb3JEXRddb6ORKdNZf15rslUi3un5l0eAbwVtPg=;
        b=ztX4AQnK+Ya/bkEw/vJKU4M+SzPdAspJ6G4oEsxpoGD/Uzvq5tThhViyrIz2/ILY2F0h3p
        5zTfJ+vKKJdW2kzugocLTn//CMR8qm+s2BgQI+qCiOIwjwPkQcBkOZhgdLogTpfV5o4DHe
        uMvEJhtz3S6gitmUWFdh0E8z9JdZtPRMbkgWumvt0bBO7I6euHh7/CcQgP5A7goY0zdmGp
        5IZvnuwt4GNXgonrXKBGEM+sl9mfSEUofeBBMEWNLJzwYmLVgAWZPyGd66fj/PiKvQQ3Bz
        fpfX+EzhEr3ZXyWvIIEwFOn2LTlIiK42Dbj8wRg1wZx3UlArSJxN7glelm0ydg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604744325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aM3mMb3JEXRddb6ORKdNZf15rslUi3un5l0eAbwVtPg=;
        b=78bw4X4IJcJpF36B0ehZxX9mRqooS6yEgUFyQwZHZyG9F3uYCE/wJ6mFDPF9BGeAXOa/52
        34lfWOT3JPNNG2DQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Recognize UV5 hubless system identifier
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201105222741.157029-4-mike.travis@hpe.com>
References: <20201105222741.157029-4-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160474432446.397.1647047519236540865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     801284f9737883a2b2639bd494455a72c82fdedf
Gitweb:        https://git.kernel.org/tip/801284f9737883a2b2639bd494455a72c82fdedf
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Thu, 05 Nov 2020 16:27:41 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:17:39 +01:00

x86/platform/uv: Recognize UV5 hubless system identifier

Testing shows a problem in that UV5 hubless systems were not being
recognized.  Add them to the list of OEM IDs checked.

Fixes: 6c7794423a998 ("Add UV5 direct references")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201105222741.157029-4-mike.travis@hpe.com


---
 arch/x86/kernel/apic/x2apic_uv_x.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0f848d6..3115caa 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -389,13 +389,20 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 			/* (Not hubless), not a UV */
 			return 0;
 
+		/* Is UV hubless system */
+		uv_hubless_system = 0x01;
+
+		/* UV5 Hubless */
+		if (strncmp(uv_archtype, "NSGI5", 5) == 0)
+			uv_hubless_system |= 0x20;
+
 		/* UV4 Hubless: CH */
-		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
-			uv_hubless_system = 0x11;
+		else if (strncmp(uv_archtype, "NSGI4", 5) == 0)
+			uv_hubless_system |= 0x10;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
 		else
-			uv_hubless_system = 0x9;
+			uv_hubless_system |= 0x8;
 
 		/* Copy APIC type */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
