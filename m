Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEC3EF36C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhHQUPc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhHQUPI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:08 -0400
Date:   Tue, 17 Aug 2021 20:14:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiWHkquSlcxbn8/JRSfn47k5SYjvOk0ghVMDX6C0a+s=;
        b=3DgZU/Bq47UsYjPQ7CVQS5vZJa0bC8xnG7gXyyAUNFtnbmw+TTzuhoIgSxhzzL9UbYz9WG
        lYHMASP7ivXgrO03SWTR+9ym4/Pg95aV9dh8ncwWJjmx3KjFXnhBqrmY88DrtQYY/DvQ1v
        uturOKHGGY5Ov33UJ+9JHw5qM+LIL/zerovlxq4Ci2eKoa6OpsSw4Bvj3mObyqgqCge9bC
        bQlORMpbU1YaZu04ooApvQi2Mt23pJQQUFr09En3JHfHEuhkYzPD2VyXhxKTB9haQXB6Jd
        +tV2WFJTTQKDZplfgnnWkiMvSYRdsjlRvm2/Qu+MNuq9bj24IrCnjlfZfMnMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiWHkquSlcxbn8/JRSfn47k5SYjvOk0ghVMDX6C0a+s=;
        b=4pONhlNW1W8ZJ8ynqor3GMQ87T8ai+kCDXChYGpopgQtDM/jcqC4nW/SMwQT0R7EOuQbXS
        PVY1Rb8uLiYP+EDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] media/atomisp: Use lockdep instead of *mutex_is_locked()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.491442626@linutronix.de>
References: <20210815211302.491442626@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127284.25758.14022052494381176514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e14c4bd12478faa13a0aceeeea6f964ff8521101
Gitweb:        https://git.kernel.org/tip/e14c4bd12478faa13a0aceeeea6f964ff8521101
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:27:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:59:15 +02:00

media/atomisp: Use lockdep instead of *mutex_is_locked()

The only user of rt_mutex_is_locked() is an anti-pattern, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.491442626@linutronix.de
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 6f5fe50..c8a6256 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1904,8 +1904,8 @@ int __atomisp_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	dev_dbg(isp->dev, "Stop stream on pad %d for asd%d\n",
 		atomisp_subdev_source_pad(vdev), asd->index);
 
-	BUG_ON(!rt_mutex_is_locked(&isp->mutex));
-	BUG_ON(!mutex_is_locked(&isp->streamoff_mutex));
+	lockdep_assert_held(&isp->mutex);
+	lockdep_assert_held(&isp->streamoff_mutex);
 
 	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		dev_dbg(isp->dev, "unsupported v4l2 buf type\n");
