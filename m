Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9131100F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 19:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhBEQzN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhBEQxa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 11:53:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4618C0613D6;
        Fri,  5 Feb 2021 10:35:12 -0800 (PST)
Date:   Fri, 05 Feb 2021 18:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612550111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Exs6lFYVVBxc5ax1bU8BhYnTez6nauNcIiJLbxsfMOY=;
        b=nTOeZ/cF70RZMY5ZToKFfQDtt5QRS36Rl4zOnxdLJHw811yswecyQJBxpBke9n9Q90FWlz
        lfuSUr99Y9omIlVjw1SOZBVp+05sUfyJsqytyxUxxLGF5iUorue1MEbe4tFUoqjqD/cbog
        5M7reDs5xNNTErV6kxuIBZ1uNgrslTGmvbHdKL+r3V4iDrTwNr9ARt6YwSWlqnQWbg5OoH
        Eykv5OHf0g8N3eMIpEFO0uq18EDobhJz7YYRVWBGRORnrqlQpnQVFLIcvm4LQVIRj/++q2
        IyN9O4UDYTkYMCFPQKdRwrJD4sKzeRW6r3NgwSdE+HNb7X4TPyCyEaOT4myZZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612550111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Exs6lFYVVBxc5ax1bU8BhYnTez6nauNcIiJLbxsfMOY=;
        b=1xQIYxMwmhNuJLCKIN/xhNa2xKuKIRVUysu8lrSsu8+jIc8Ygd467aSM3tLwegNtNV/j6n
        RIzSgJrTFyGAXTAg==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timens: Delete no-op time_ns_init()
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201228215402.GA572900@localhost.localdomain>
References: <20201228215402.GA572900@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <161255011051.23325.10863511684535856878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     174bcc691f44fdd05046c694fc650933819f72c7
Gitweb:        https://git.kernel.org/tip/174bcc691f44fdd05046c694fc650933819f72c7
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Tue, 29 Dec 2020 00:54:02 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Feb 2021 19:32:09 +01:00

timens: Delete no-op time_ns_init()

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrei Vagin <avagin@gmail.com>
Link: https://lore.kernel.org/r/20201228215402.GA572900@localhost.localdomain
---
 kernel/time/namespace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 6ca625f..12eab0d 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -465,9 +465,3 @@ struct time_namespace init_time_ns = {
 	.ns.ops		= &timens_operations,
 	.frozen_offsets	= true,
 };
-
-static int __init time_ns_init(void)
-{
-	return 0;
-}
-subsys_initcall(time_ns_init);
