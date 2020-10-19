Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F1292C26
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgJSRCt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:02:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbgJSRCs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:48 -0400
Date:   Mon, 19 Oct 2020 17:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vecU3kJYuPpyYolsjCKQ+Gp5zwhRerMOKy1v8a747ho=;
        b=2Af5gie/oT3/668kOuhPl6jbhMlJpjLJ3vdU6LC6hkwhwPRkuJ/ZfvPI7fI4H4qzj22gmS
        iDCqQASgxRvs7T4PYGwHs8Em92GYO94JCTooySij610i1oyPyyn7mX7F/3BlR0cC2n6hAn
        RCpyt8jPCwxV2QyHSNbXsLUGW64G0y9fw4+kc09oeEw0P+FJH4wFVYJI2oJA7hvIPzeugk
        /3JRziJUfPUC5S9nSO+FhybvGkDVCgjVYpntYyAcXOr6OiuH9f/vi2yiSRGiTqZIMsAY4W
        lxdCM2F/RgAa6qEw7Uv/qjQfSwulwdmhptgBoE0/849SHnzkjzjikuNNvtoA6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vecU3kJYuPpyYolsjCKQ+Gp5zwhRerMOKy1v8a747ho=;
        b=LKEGML9uTZhpZ2frwyYCbD6D9RzWvYSqI/63GGTqCl5R4AFTrer/WfTYxi5RpWHO/upS5K
        trsw4m1Steiq9VCg==
From:   "tip-bot2 for Oliver Neukum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] media: usbtv: Fix refcounting mixup
Cc:     Oliver Neukum <oneukum@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696584.7002.2780733511206872163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1eaed405fcd22e52a438b619e6ea85539f1c150a
Gitweb:        https://git.kernel.org/tip/1eaed405fcd22e52a438b619e6ea85539f1c150a
Author:        Oliver Neukum <oneukum@suse.com>
AuthorDate:    Thu, 24 Sep 2020 11:14:10 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:21 +02:00

media: usbtv: Fix refcounting mixup

commit bf65f8aabdb37bc1a785884374e919477fe13e10 upstream.

The premature free in the error path is blocked by V4L
refcounting, not USB refcounting. Thanks to
Ben Hutchings for review.

[v2] corrected attributions

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 50e704453553 ("media: usbtv: prevent double free in error case")
CC: stable@vger.kernel.org
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/usbtv/usbtv-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index ee9c656..2308c0b 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -113,7 +113,8 @@ static int usbtv_probe(struct usb_interface *intf,
 
 usbtv_audio_fail:
 	/* we must not free at this point */
-	usb_get_dev(usbtv->udev);
+	v4l2_device_get(&usbtv->v4l2_dev);
+	/* this will undo the v4l2_device_get() */
 	usbtv_video_free(usbtv);
 
 usbtv_video_fail:
