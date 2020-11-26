Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81012C5BE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Nov 2020 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404921AbgKZSUs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Nov 2020 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404914AbgKZSUs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Nov 2020 13:20:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBABC0617A7;
        Thu, 26 Nov 2020 10:20:48 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+JyQ7ZBvHvYfLoIbhh8sWIoh3T7v7Ij/6iWdz0ejY4=;
        b=OhU7t92epgnWlB6htk1alcXLC9A5YofDnd+NIKviCzUy+aZZ5u3FafK3rXO/CvGObhE+2d
        bGOR4hC0jfFUhfMGgTBdKpGmdY8S+YO/WCA4tJgPDGVqjjdh92hSv7ieHg1fe4KvXAn4ZE
        KT/AwECudSekU4SFW/MO8Mh40MV2j5NkCLxRl/at0H4c/abH3sdrOsJGuKJS3LiRAVAcq0
        PBXYS/gZWfN0pkyYouf0aXY4MZOXnAOA/mEswLiyXVk0W38Y3Wf1khkurT1gz95X8vvkAt
        9nQFpst+ekuuwjFJTwpuNwSBJT4eoMXD6PyVKUMlTRNiAu0MiSXZnsf82zdUlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+JyQ7ZBvHvYfLoIbhh8sWIoh3T7v7Ij/6iWdz0ejY4=;
        b=z6Vjgdh8wdJjRJe94m1yi1hSjRJRLKyvUR758TzqSJkR6u04J5hmRQpfUzKKk9kM1Q0ypc
        Oo9nF46RhqENdIDA==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125175444.279074-6-justin.ernst@hpe.com>
References: <20201125175444.279074-6-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <160641484443.3364.16345336788664309951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     caf371103ea17de58251714131b06682d86b0df8
Gitweb:        https://git.kernel.org/tip/caf371103ea17de58251714131b06682d86b0df8
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Wed, 25 Nov 2020 11:54:44 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Nov 2020 17:17:18 +01:00

x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

Add an entry and email address for the new uv_sysfs driver and
its maintainer.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201125175444.279074-6-justin.ernst@hpe.com
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70..bcf83e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18354,6 +18354,12 @@ F:	include/uapi/linux/uuid.h
 F:	lib/test_uuid.c
 F:	lib/uuid.c
 
+UV SYSFS DRIVER
+M:	Justin Ernst <justin.ernst@hpe.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/uv_sysfs.c
+
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
