Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4716BBCA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2020 09:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgBYIYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 Feb 2020 03:24:07 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37061 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgBYIYH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 Feb 2020 03:24:07 -0500
Received: by mail-lj1-f169.google.com with SMTP id q23so13048627ljm.4
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2020 00:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KBmyMZAeqjL/dWehJYWIZj/HK+sTTg1x4dJjtWNJz4=;
        b=Wd1ymYRw9ghLg/v6CP8+SveZ4OsVVukkCJXUZ+7SUt/vxJsv4eaS/BLi0CELES5LvM
         u+/5grfOt1wKhyrfkyIMNumcHaIsS/tUhp7iedp58BWEj9mKJf9q6edsZseaFujO/J4v
         vFK+l9T1tlyC4e1Z+oXvztoTGVSB9/eTRDALR35uR10+F6mqe6PqCelVTTZItYMW/TH2
         6vbJnSD2DsMY6074zMOVSqSZnGve+cPA4QB9rI6piJ+EHbuQrknS8NdnTxQjF5TGYjfl
         Oa2EzmUjgPGCTm+2M+zdwtZWMq555nr4lUMRqirC+hurQ8IW6s8rJO6WJlegs6yfrV9a
         nN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KBmyMZAeqjL/dWehJYWIZj/HK+sTTg1x4dJjtWNJz4=;
        b=taDdoDXmMKsbf7Zvenku/pJO4Ylh7FVPJV921GWUO6YrWCK+lmEWt3WI+B/lJDpamY
         HAkBG6hmLFp6z8peC+csevsSkrjLUHCGspzq2z2sR/HV1YI5kcP0PuqKO0wgcodAVIGH
         N3GeYRW9SE8x17f1iZ+J/Nx9Prs4YFz/5EYAXKzugSTqw870TUDv0qv2NZ3rPKMxCz6u
         2uZOa6X8R20aKW+fG2B/NU8PeVFB02rKiRVySIOTcXpJdTEUwk+YQwxEj7yWISFZkfHM
         rVNiJOiBUcx/j0QR9+erkEOOApvW7oebDLa6US7CvHd3FOWvH8N0e8F/JH8GpbUstAZN
         6h8Q==
X-Gm-Message-State: APjAAAUK6p77c4aIDM4a2Eaigrafn+0u7Bb1RjVJ9Xygw6bdG4svPgNp
        RyOSP+OkQy+MBDXCj9irMzEXl93WEm1tgZ5h51O9vMb2
X-Google-Smtp-Source: APXvYqy8RsIavee13RX2Ng/Iy0dV1rVHxkrrl/x6+fmkPYOKcK8Y0NEg8xCGCBuHo+/9wPVTBt/y2eFuiRQQ6SmYM7o=
X-Received: by 2002:a2e:9596:: with SMTP id w22mr30879694ljh.21.1582619045157;
 Tue, 25 Feb 2020 00:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20200224095223.13361-9-mgorman@techsingularity.net>
 <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2> <jhj36b06klb.fsf@arm.com>
In-Reply-To: <jhj36b06klb.fsf@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Feb 2020 09:23:53 +0100
Message-ID: <CAKfTPtDSYRaLsxBLi4+=Z8zT4mpXo269MX3TYdxkjD1GSq5d7A@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/pelt: Add a new runnable average signal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, 24 Feb 2020 at 17:01, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> tip-bot2 for Vincent Guittot writes:
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> With the fork time initialization thing being sorted out, the rest of the
> runnable series can claim my
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks

>
> but I doubt any of that is worth the hassle since it's in tip already. Just
> figured I'd mention it, being in Cc and all :-)
