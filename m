Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8636A3CF879
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jul 2021 12:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhGTKRD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Jul 2021 06:17:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhGTKOt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Jul 2021 06:14:49 -0400
Date:   Tue, 20 Jul 2021 10:55:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626778523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDPnpQrIrSiEs1rRVmbSlyN4aoCWzjWyl+el3Yf10EM=;
        b=nolEEyC31fAMxe7bqB2GEUmzk/yfWVm7SMk5GIOXhYX/yiDgpVHzhcHC1GmEZYJCZi4Ouw
        e5J69bYybEvp8TdHk+vC0w6wUi4uAypg84XwVHaH5Y3JyZqXvTvojfckCTcW70FQG/r29z
        9gwf0/knUElYnNg86lSCaUdzaFHnuVsl8mo5MzsJgQb5thlYAUgub53HjFbXYN2tVbJR4s
        TcluNfj/wgk9wPq9VnpfiwzOzUCS+SGd15ucilnvt17GVp7WLUHfd0IMVejpas9xhus+pE
        8fuZoWb+45Zlu95rS9AnwSGpDWWG8c4cODawWyJwY9O8UZM7Iju/8O/QGCVf9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626778523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDPnpQrIrSiEs1rRVmbSlyN4aoCWzjWyl+el3Yf10EM=;
        b=mON+3sDrXQJ8U3dpTJw0ieLn+tOyAQgGoq+C+CFtixIMv1MSirpP+V+lIVLCJHsk5AI2VW
        zE/bFEPhydYJhyBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] Merge branch 'timers/urgent' of
 git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into
 timers/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210715104218.81276-1-frederic@kernel.org>
References: <20210715104218.81276-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162677852315.395.402117055218610016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ff5a6a3550cef4a272fee19520a13699343b6a47
Gitweb:        https://git.kernel.org/tip/ff5a6a3550cef4a272fee19520a13699343b6a47
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Jul 2021 12:51:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jul 2021 12:51:23 +02:00

Merge branch 'timers/urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into timers/urgent

Pull dyntick fixes from Frederic Weisbecker:

  - Fix a rearm race in the posix cpu timer code
  - Handle get_next_timer_interrupt() correctly when no timers are pending

Link: https://lore.kernel.org/r/20210715104218.81276-1-frederic@kernel.org
---
