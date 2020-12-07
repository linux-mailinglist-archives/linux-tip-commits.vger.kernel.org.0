Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0962D1D76
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 23:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLGWi0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 17:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgLGWiZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 17:38:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774FC061793;
        Mon,  7 Dec 2020 14:37:45 -0800 (PST)
Date:   Mon, 07 Dec 2020 22:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bghgC8s1RZpcGCj7iPmhAPelRLZ5y+oqGwRK63rNvoU=;
        b=ZQXaYFr9JVmccDrmDNEb+9JVbqaZurVuHCkbdDe2AUc8ougOhcD8LmrwBBGhyTGEiz3a9y
        yCHQIXK2wDEYaBEEo7M+Vyx4GijySQ0wxDBZTE6gYvkPNGmOmZw71NuwL7+jWLX/QeL3pN
        ImU5w35vKWCDhbsV7I+qVu9ZKCFcOPULVCoAQXnSc+QFxxisux24seYozt5y9EeDRqTz5T
        LMtDi5YbXmtdMLZ/tg4momIs/z507z9bKXjWTd/m36lvoSXuVLuWDwJgzUegKPFpVFQwv2
        hLgdMFq8Lfrf/4u99Icubx9klfBUn3I5+d0JX3NMjYx9afZwO7uf9CDUiSGx/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607380663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bghgC8s1RZpcGCj7iPmhAPelRLZ5y+oqGwRK63rNvoU=;
        b=hmVpTaWJFshl3fJArBd3tneT9Xxsn4Oy9XmWLtHvUQCRJ98y/Ku0xGkRbXxli7j6Jqm1Pt
        ayOG5LYFkJY1CFCA==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add sysfs leaves to replace
 those in procfs
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128034227.120869-3-mike.travis@hpe.com>
References: <20201128034227.120869-3-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160738066283.3364.14396167239614008322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     612a0063c9ba3aba79b9006faa0edad5f9d41162
Gitweb:        https://git.kernel.org/tip/612a0063c9ba3aba79b9006faa0edad5f9d41162
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 27 Nov 2020 21:42:24 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 19:49:01 +01:00

x86/platform/uv: Add sysfs leaves to replace those in procfs

Add uv_sysfs leaves to display the info.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201128034227.120869-3-mike.travis@hpe.com
---
 drivers/platform/x86/uv_sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index c27f5ff..922d32f 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -736,17 +736,35 @@ static ssize_t uv_type_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "%s\n", uv_type_string());
 }
 
+static ssize_t uv_archtype_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return uv_get_archtype(buf, PAGE_SIZE);
+}
+
+static ssize_t uv_hub_type_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
+}
+
 static struct kobj_attribute partition_id_attr =
 	__ATTR(partition_id, 0444, partition_id_show, NULL);
 static struct kobj_attribute coherence_id_attr =
 	__ATTR(coherence_id, 0444, coherence_id_show, NULL);
 static struct kobj_attribute uv_type_attr =
 	__ATTR(uv_type, 0444, uv_type_show, NULL);
+static struct kobj_attribute uv_archtype_attr =
+	__ATTR(archtype, 0444, uv_archtype_show, NULL);
+static struct kobj_attribute uv_hub_type_attr =
+	__ATTR(hub_type, 0444, uv_hub_type_show, NULL);
 
 static struct attribute *base_attrs[] = {
 	&partition_id_attr.attr,
 	&coherence_id_attr.attr,
 	&uv_type_attr.attr,
+	&uv_archtype_attr.attr,
+	&uv_hub_type_attr.attr,
 	NULL,
 };
 
