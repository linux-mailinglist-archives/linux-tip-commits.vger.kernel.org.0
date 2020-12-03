Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F42CD0B7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgLCICl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgLCICl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 03:02:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3AC061A51;
        Thu,  3 Dec 2020 00:02:01 -0800 (PST)
Date:   Thu, 03 Dec 2020 08:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606982518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2gzum94MVzbA49l84sMu0yte4pizNa3znOvuSTlN/I=;
        b=2+4TG3Xz9sC4hHtQ8qS/WsMZAE+ICrv8ITGO2oc0Ho9XksuAIqxsDCEbsVHDIhbogjQ7do
        BWwl+29pxhg/toR22uCa05uSGEgZR2589JYWBpsjfzIpbWrmO3H+oFZbZjzLMMvU3DQFSw
        8TfAww21OMoJqM8YVx3UmRH3n2wedC6JyRDV4TP7E559SDo5QxdPjgVNZaJ9MwCkb0YNb0
        mfH6fzQy6Rtg9RbSKRW8p9DA/YoQNarrZgXgGWHk6PR9zvufpGN5craJ0bRszPTJeVSR+D
        F7ih7yYOJmIdPqAUTx4cAfhixYgvR0TC6vLjB0TTHSb/p3/b6u04g0p6hd8o7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606982518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2gzum94MVzbA49l84sMu0yte4pizNa3znOvuSTlN/I=;
        b=XTD9YRb0dulCFGuG7RJjMTsQ7YHRKoVkuzfTeof0YEKSgxk6PkPlxHYn0HtusgbtQfACDa
        B1WPO6EjesqppuCg==
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Make uv_pcibus_kset and
 uv_hubs_kset static
Cc:     Zou Wei <zou_wei@huawei.com>, Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
References: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Message-ID: <160698251802.3364.12660165138923593684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0c683e9de0c78ee53e220eac9ee3604ca662737a
Gitweb:        https://git.kernel.org/tip/0c683e9de0c78ee53e220eac9ee3604ca662737a
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Mon, 30 Nov 2020 19:11:53 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Dec 2020 08:53:47 +01:00

x86/platform/uv: Make uv_pcibus_kset and uv_hubs_kset static

Fix the following sparse warnings:

  drivers/platform/x86/uv_sysfs.c:22:13: warning: symbol \
	  'uv_pcibus_kset' was not declared. Should it be static?
  drivers/platform/x86/uv_sysfs.c:23:13: warning: symbol \
	  'uv_hubs_kset' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/1606734713-43919-1-git-send-email-zou_wei@huawei.com
---
 drivers/platform/x86/uv_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index e17ce8c..c27f5ff 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -19,8 +19,8 @@
 #define INVALID_CNODE -1
 
 struct kobject *sgi_uv_kobj;
-struct kset *uv_pcibus_kset;
-struct kset *uv_hubs_kset;
+static struct kset *uv_pcibus_kset;
+static struct kset *uv_hubs_kset;
 static struct uv_bios_hub_info *hub_buf;
 static struct uv_bios_port_info **port_buf;
 static struct uv_hub **uv_hubs;
