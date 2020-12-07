Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314182D1D7B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 23:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgLGWid (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 17:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgLGWiZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 17:38:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF67C061794;
        Mon,  7 Dec 2020 14:37:45 -0800 (PST)
Date:   Mon, 07 Dec 2020 22:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uSze7RKme90BZuxOdHd6kn3kKlXBTSpreS9VA9MRyw=;
        b=xfTIhFlaTda8U1CknalXxw6JZ0RhS2S2FpRA9aDDjtK2zA5J459G5bMLJyIwT4s+IHVdCH
        pFRpAOi+BQe9laXNZ1sKyT7i42WOnCiLkJa7y9Kuk5WNhbhyQRyUyYsGR/T3pF+z3+tz4f
        +K0s9J5pr6CISCbV9ws1o/WPkaXU9CG8yX4Ox2BPMQHU8PVeXR8Of+5oFHw+WzqHL4emDN
        JVf+BMmvfAZaZtrx+LMUZQdSoqc2x3DG7BCv+fjC7pAL4yIlhaK00AaldEuhmnMoqQ+/sI
        9ccz45d01adIcIrT4PhOw+pyR0xSbOLLDTKZcsWbPkC3fVZloffdIwL3Rzhomg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uSze7RKme90BZuxOdHd6kn3kKlXBTSpreS9VA9MRyw=;
        b=WP9FN9YEclQmqaw0zsO3y9sWoZlIS2p3RyhvV+Y83VJEFd++FbzvnVzAWYFvziy/TGLjUN
        bCgYPf4AZLjNFWAg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add sysfs hubless leaves
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128034227.120869-4-mike.travis@hpe.com>
References: <20201128034227.120869-4-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160738066266.3364.17029306692868315599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     433e817ae157479844d84b186dd4d165a3f2b06e
Gitweb:        https://git.kernel.org/tip/433e817ae157479844d84b186dd4d165a3f2b06e
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 27 Nov 2020 21:42:25 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 19:51:05 +01:00

x86/platform/uv: Add sysfs hubless leaves

Add uv_sysfs hubless leaves for UV hubless systems.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201128034227.120869-4-mike.travis@hpe.com
---
 drivers/platform/x86/uv_sysfs.c | 52 ++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 922d32f..7badcfa 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -44,6 +44,8 @@ static const char *uv_type_string(void)
 		return "5.0";
 	else if (is_uv2_hub())
 		return "3.0";
+	else if (uv_get_hubless_system())
+		return "0.1";
 	else
 		return "unknown";
 }
@@ -748,6 +750,12 @@ static ssize_t uv_hub_type_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
 }
 
+static ssize_t uv_hubless_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_get_hubless_system());
+}
+
 static struct kobj_attribute partition_id_attr =
 	__ATTR(partition_id, 0444, partition_id_show, NULL);
 static struct kobj_attribute coherence_id_attr =
@@ -758,6 +766,8 @@ static struct kobj_attribute uv_archtype_attr =
 	__ATTR(archtype, 0444, uv_archtype_show, NULL);
 static struct kobj_attribute uv_hub_type_attr =
 	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
+static struct kobj_attribute uv_hubless_attr =
+	__ATTR(hubless, 0444, uv_hubless_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
@@ -805,11 +815,36 @@ static int initial_bios_setup(void)
 	return 0;
 }
 
+static struct attribute *hubless_base_attrs[] = {
+	&partition_id_attr.attr,
+	&uv_type_attr.attr,
+	&uv_archtype_attr.attr,
+	&uv_hubless_attr.attr,
+	NULL,
+};
+
+static struct attribute_group hubless_base_attr_group = {
+	.attrs = hubless_base_attrs
+};
+
+
+static int __init uv_sysfs_hubless_init(void)
+{
+	int ret;
+
+	ret = sysfs_create_group(sgi_uv_kobj, &hubless_base_attr_group);
+	if (ret) {
+		pr_warn("sysfs_create_group hubless_base_attr_group failed\n");
+		kobject_put(sgi_uv_kobj);
+	}
+	return ret;
+}
+
 static int __init uv_sysfs_init(void)
 {
 	int ret = 0;
 
-	if (!is_uv_system())
+	if (!is_uv_system() && !uv_get_hubless_system())
 		return -ENODEV;
 
 	num_cnodes = uv_num_possible_blades();
@@ -820,6 +855,10 @@ static int __init uv_sysfs_init(void)
 		pr_warn("kobject_create_and_add sgi_uv failed\n");
 		return -EINVAL;
 	}
+
+	if (uv_get_hubless_system())
+		return uv_sysfs_hubless_init();
+
 	ret = sysfs_create_group(sgi_uv_kobj, &base_attr_group);
 	if (ret) {
 		pr_warn("sysfs_create_group base_attr_group failed\n");
@@ -857,10 +896,19 @@ err_create_group:
 	return ret;
 }
 
+static void __exit uv_sysfs_hubless_exit(void)
+{
+	sysfs_remove_group(sgi_uv_kobj, &hubless_base_attr_group);
+	kobject_put(sgi_uv_kobj);
+}
+
 static void __exit uv_sysfs_exit(void)
 {
-	if (!is_uv_system())
+	if (!is_uv_system()) {
+		if (uv_get_hubless_system())
+			uv_sysfs_hubless_exit();
 		return;
+	}
 
 	pci_topology_exit();
 	uv_ports_exit();
