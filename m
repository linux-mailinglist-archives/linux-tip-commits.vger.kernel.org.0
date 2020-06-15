Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A591F8F7D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jun 2020 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgFOHZv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgFOHZt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 03:25:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51353C05BD43
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 00:25:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e4so17909010ljn.4
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SoSPRx0KWtA6g8DOeO4fbOiBJz8HrEKhF1kXWLBN7w=;
        b=DP9hF01kqgES9xL3k2lhw4H2l39p/FA2fzB0Zwg8QVob9Qe8bJMJJw2no2a8+oeR7b
         I3g3EZNVTj0oFuLgT1Mb7r9nrM0g9IkPaOSfK5FRgcJoPNY+vQqHV57aeDZFyxRCF9kx
         GP7Enm1ZfIopI06LA/cNTs4NPGflEEjy2VqFrQivdlhUhKaLe98TMFzWkOZbqNry3h61
         a1ggzFRgAYWD2g6Pjhpky61raMvXQwhbcpE7SnOHcfzkeCtRIihEYXFFrytZwlY0wW5s
         fyNJIFLOnkkflV/7aFDCVoGXrv68K2fSniL/v/osMpUlAfYaQ1b+4T9eNJ/C//vV0+rS
         xH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SoSPRx0KWtA6g8DOeO4fbOiBJz8HrEKhF1kXWLBN7w=;
        b=tENrTfL05Esd2o1v3qBfZe2TyPvE61+DYmwNHxUmVcmV/w64PVq8SE+U9KBbGa3cV2
         qxxXBB7cyg3NMOtjQsMhngbr814qouAtlbsvtsBhxKm9DwtJe4lWg1O2dlyfp3d3360y
         B1y8S7eu/o3bCBL6AnZhH2NFIwRCib9oTBuO3BOFeo1rEDZWOGrLF5zrg44dxJYkjzVE
         K2FNiKqJPBr13oafoFkYTfmvCYSyqvzAkbHnQB78vepDJpugnB66nWd1ITzFr2G78Z4P
         YhDxPalKo5q6n/MbnoyXT716kkietUFcX6Re1JWOSr3j7GBUEx8/VLGPtEmwNHALZIPZ
         ac/w==
X-Gm-Message-State: AOAM530VkrJjH3ysoIfYKKH2cGKfaKLTzeXetkMymHbEDVVJUhWsGGHP
        hnVyC5/BdffUHt3vUacMati7/tYT7apTcoaZ8fxs
X-Google-Smtp-Source: ABdhPJwuVQNAuu6XqKxf+UWLMrl+UfwiMiHdojHlbYQ1yU51SXmHVFfBBmpWTBEGizOzKvwYFr4LHmq6j0Ikdc7ldkM=
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr13195530ljl.72.1592205947327;
 Mon, 15 Jun 2020 00:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <159169282952.17951.3529693809120577424.tip-bot2@tip-bot2>
 <20200611140951.GD30352@zn.tnic> <CAN_oZf16odNhpY6_LqkVY2wpy90jKM9-vgKo4LE8OJ-QTDCKiw@mail.gmail.com>
 <20200611154356.GE30352@zn.tnic> <20200615065806.GB14668@zn.tnic>
In-Reply-To: <20200615065806.GB14668@zn.tnic>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Mon, 15 Jun 2020 00:25:36 -0700
Message-ID: <CAN_oZf3exijOHJmY7UqDVwWma_fMqiXhen6gSsSSBnxRSeFtPQ@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation: Merge one test in spectre_v2_user_select_mitigation()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Thanks, Borislav.
