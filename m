Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA72C2C3625
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 02:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKYBPa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 20:15:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKYBPa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 20:15:30 -0500
Date:   Wed, 25 Nov 2020 01:15:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606266928;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/d5YTo6n8Enub+16Ldkxksm0vezqxRjVltvr8a0G3s=;
        b=RGg+VinQHidpAHmFpAFnPTZX19ZvhL+gg85imuYH3oVKJTxyUXsfwbcWNND0YJPQj8SlH6
        8Nf/w6uvYLJFog6VgeNO90SEPrUmxNa+xywUTzi+JXiJ7UUM5ThpsjrAwSWYlM7DqD0Vg7
        D//zldgFzrVgLK6ue46Vn8s2RkpDWby6/l5ljyPbXhIV5eAx1ash8Wg+etxAS82hgk9ekt
        vnbxmNDbJ8RTrWC4H4OAfX7uXDhQcdVFU6zMf/kYuo/kY05Mfdc0PDOGHKMoSXI2dV4St/
        HKn1e/cR/p0ny8kKvUFvuo43tWf1+5oeMSGdp05eQNde08eQuVJH9tYnk5dkCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606266928;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/d5YTo6n8Enub+16Ldkxksm0vezqxRjVltvr8a0G3s=;
        b=H6YB2B3eIRQeqUGgIV/acbUXTeBCj+O1qTgNFf4LQbm+yHd/lPlMMvbXKAVggeH9o1lbUM
        2hQnGUTpI2UWRrCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.10-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201122184752.553990-1-maz@kernel.org>
References: <20201122184752.553990-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160626692776.3364.7995872010467639203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7032908cd5842af9710de4815a456241b5e6d2d1
Gitweb:        https://git.kernel.org/tip/7032908cd5842af9710de4815a456241b5e6d2d1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Nov 2020 00:56:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Nov 2020 00:56:28 +01:00

Merge tag 'irqchip-fixes-5.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Fix Exiu driver trigger type when using ACPI

 - Fix GICv3 ITS suspend/resume to use the in-kernel path
   at all times, sidestepping braindead firmware support

Link: https://lore.kernel.org/r/20201122184752.553990-1-maz@kernel.org
---
